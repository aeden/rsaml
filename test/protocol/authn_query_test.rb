require File.dirname(__FILE__) + '/../test_helper'

class AuthnQueryTest < Test::Unit::TestCase
  include RSAML::Protocol::Query
  
  context "an authn query" do
    setup do
      @query = AuthnQuery.new(Subject.new('example'))
    end
    context "when producing xml" do
      should "include a subject" do
        assert_match('<saml:Subject>example</saml:Subject>', @query.to_xml)
      end
      should "optionally include a SessionIndex" do
        @query.session_index = '123'
        assert_match('<samlp:AuthnQuery SessionIndex="123"', @query.to_xml)
      end
    end
  end
end