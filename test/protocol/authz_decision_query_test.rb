require File.dirname(__FILE__) + '/../test_helper'

class AuthzDecisionQueryTest < Test::Unit::TestCase
  include RSAML::Protocol::Query
  
  context "an authz decision query" do
    setup do
      @query = AuthzDecisionQuery.new(Subject.new('example'))
      @query.resource = 'http://somesite/some/resource'
      @query.actions << Action.new
    end
    should "be valid" do
      assert_nothing_raised { @query.validate }
    end
    context "when producing xml" do
      should "include a subject" do
        assert_match('<saml:Subject>example</saml:Subject>', @query.to_xml)
      end
      should "include a Resource attribute" do
        assert_match(%Q(<samlp:AuthzDecisionQuery Resource="#{@query.resource}"), @query.to_xml)
      end
      should "include actions" do
        
      end
    end
  end
end