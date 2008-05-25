require File.dirname(__FILE__) + '/test_helper'

class StatementTest < Test::Unit::TestCase
  context "an authentication statement" do
    setup do
      @statement = AuthenticationStatement.new(AuthenticationContext.new())
    end
    should "always have a UTC time for authn_instant" do
      assert_not_nil @statement.authn_instant
      assert @statement.authn_instant.utc?
    end
    should "be valid" do
      assert_nothing_raised do
        @statement.validate
      end
    end
    should "be invalid if authn_instant is not UTC" do
      @statement.authn_instant = Time.now
      assert_raise ValidationError do
        @statement.validate
      end
    end
    context "when producing xml" do
      should "always include authn_instant" do
        assert_match(/<saml:AuthnStatement AuthnInstant="#{date_match}">/, @statement.to_xml)
      end
      should "always include authn_context" do
        assert_match(/<saml:AuthnContext>/, @statement.to_xml)
      end
      should "optionally include a session index" do
        @statement.session_index = '12345'
        assert_match(/SessionIndex="\d+"/, @statement.to_xml)
      end
      should "optionally include a session not on or after date" do
        @statement.session_not_on_or_after = (Time.now + 5.days).utc
        assert_match(/SessionNotOnOrAfter="#{date_match}"/, @statement.to_xml)
      end
    end
  end
  context "an attribute statement" do
    setup do
      @statement = AttributeStatement.new
      @statement.attributes << Attribute.new('email', 'someone@someplace.com')
    end
    should "be valid" do
      assert_nothing_raised { @statement.validate }
    end
    should "not be valid if empty attributes" do
      assert_raise ValidationError do
        @statement.attributes.clear
        @statement.validate
      end
    end
    context "when producing xml" do
      should "include at least on attribute" do
        assert_match(/<saml:AttributeStatement><saml:Attribute Name="email"><saml:AttributeValue>someone@someplace.com<\/saml:AttributeValue><\/saml:Attribute><\/saml:AttributeStatement>/, @statement.to_xml)
      end
    end
  end
  
  context "an authorization decision statement" do
    setup do
      @statement = AuthorizationDecisionStatement.new
      @statement.resource = 'file://some/resource'
      @statement.decision = 'Permit'
      @statement.actions << Action.new('Read')
    end
    should "be valid" do
      assert_nothing_raised { @statement.validate }
    end
    should "not be valid if resource is nil" do
      assert_raise ValidationError do
        @statement.resource = nil
        @statement.validate
      end
    end
    should "not be valid if decision is nil" do
      assert_raise ValidationError do
        @statement.decision = nil
        @statement.validate
      end
    end
    should "not be valid if no actions are specified" do
      assert_raise ValidationError do
        @statement.actions.clear
        @statement.validate
      end
    end
    context "when producing xml" do
      should "include the AuthzStatement tag" do
        assert_match(%Q(<saml:AuthzStatement), @statement.to_xml)
      end
      should "include a Resource attribute" do
        assert_match(%Q(Resource="file://some/resource"), @statement.to_xml)
      end
      should "include a Decision attribute" do
        assert_match(%Q(Decision="Permit"), @statement.to_xml)
      end
    end
  end
end