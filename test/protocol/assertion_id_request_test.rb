require File.dirname(__FILE__) + '/../test_helper'

class AssertionIdRequestTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "an assertion id request instance" do
    setup do
      @request = AssertionIDRequest.new
      @request.assertion_id_refs << AssertionIDRef.new('xyz')
    end
    context "when producing xml" do
      should "output the samlp:AssertionIDRequest element" do
        assert_match '<samlp:AssertionIDRequest>', @request.to_xml
      end
      should "include the assertion id ref children" do
        assert_match '<saml:AssertionIDRef>xyz</saml:AssertionIDRef>', @request.to_xml
      end
    end
  end
end