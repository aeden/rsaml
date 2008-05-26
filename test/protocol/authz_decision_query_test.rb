require File.dirname(__FILE__) + '/../test_helper'

class AuthzDecisionQueryTest < Test::Unit::TestCase
  include RSAML::Protocol::Query
  
  context "an authz decision query" do
    setup do
      @query = AuthzDecisionQuery.new(Subject.new('example'))
      @query.resource = 'http://somesite/some/resource'
      @query.actions << Action.new('Read')
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
        assert_match(%Q(<saml:Action Namespace="urn:oasis:names:tc:SAML:1.0:action:rwedc-negation">Read</saml:Action>), @query.to_xml)
      end
      should "optionally include evidence" do
        @query.evidence = Evidence.new
        assert_match(%Q(<saml:Evidence></saml:Evidence>), @query.to_xml)
      end
    end
  end
end