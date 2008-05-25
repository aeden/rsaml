require File.dirname(__FILE__) + '/test_helper'

class AuthenticationContextTest < Test::Unit::TestCase
  context "an authentication context" do
    setup do
      @authn_context = AuthenticationContext.new
    end
    context "when producing xml" do
      should "optionally have a class reference" do
        @authn_context.class_reference = 'http://example.com/class_ref'
        assert_equal '<saml:AuthnContext><saml:AuthnContextClassRef>http://example.com/class_ref</saml:AuthnContextClassRef></saml:AuthnContext>', @authn_context.to_xml
      end
      should "optionally have a context declaration" do
        @authn_context.context_declaration = 'example'
        assert_equal '<saml:AuthnContext><saml:AuthnContextDecl>example</saml:AuthnContextDecl></saml:AuthnContext>', @authn_context.to_xml
      end
      should "optionally have a context declaration ref" do
        @authn_context.context_declaration_ref = 'http://example.com/declaration_ref'
        assert_equal '<saml:AuthnContext><saml:AuthnContextDeclRef>http://example.com/declaration_ref</saml:AuthnContextDeclRef></saml:AuthnContext>', @authn_context.to_xml
      end
      should_eventually "optionally have zero or more authenticating authority instances" do
        
      end
    end
  end
end