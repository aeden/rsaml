require File.dirname(__FILE__) + '/test_helper'

class ProxyRestrictionTest < Test::Unit::TestCase
  context "a proxy restriction" do
    setup do
      @proxy_restriction = ProxyRestriction.new
    end
    context "when producing xml" do
      should "optionally include a count" do
        @proxy_restriction.count = 1
        assert_equal '<saml:ProxyRestriction Count="1"></saml:ProxyRestriction>', @proxy_restriction.to_xml
      end
      should "optionally include audiences" do
        audience = Audience.new('some_uri')
        @proxy_restriction.audiences << audience
        assert_equal '<saml:ProxyRestriction><saml:Audience>some_uri</saml:Audience></saml:ProxyRestriction>', @proxy_restriction.to_xml
      end
    end
  end
end