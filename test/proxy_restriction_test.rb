require File.dirname(__FILE__) + '/test_helper'

class ProxyRestrictionTest < Test::Unit::TestCase
  context "a proxy restriction" do
    setup do
      @proxy_restriction = ProxyRestriction.new
    end
    context "when producing xml" do
      should "optionally include a count" do
        @proxy_restriction.count = 1
        assert_equal '<ProxyRestriction Count="1"></ProxyRestriction>', @proxy_restriction.to_xml
      end
      should "optionally include audiences" do
        audience = Audience.new('some_uri')
        @proxy_restriction.audiences << audience
        assert_equal '<ProxyRestriction><Audience>some_uri</Audience></ProxyRestriction>', @proxy_restriction.to_xml
      end
    end
  end
end