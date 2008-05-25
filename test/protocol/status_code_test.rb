require File.dirname(__FILE__) + '/../test_helper'

class StatusCodeTest < Test::Unit::TestCase
  include RSAML::Protocol
  
  context "the StatusCode class" do
    should "have 4 top-level status codes" do
      assert_equal 4, StatusCode.top_level_status_codes.length
    end
    should "have 19 second-level status codes" do
      assert_equal 19, StatusCode.second_level_status_codes.length
    end
    should "have constants for the top-level status codes" do
      assert_equal StatusCode.top_level_status_codes[:success], StatusCode::SUCCESS
      assert_equal StatusCode.top_level_status_codes[:requestor], StatusCode::REQUESTOR
      assert_equal StatusCode.top_level_status_codes[:responder], StatusCode::RESPONDER
      assert_equal StatusCode.top_level_status_codes[:version_mismatch], StatusCode::VERSION_MISMATCH
    end
  end
  
  context "a success status code instance" do
    setup do
      @status_code = StatusCode::SUCCESS
    end
    context "when producing xml" do
      should "have the samlp:StatusCode element name" do
        assert_match(/<samlp:StatusCode/, @status_code.to_xml)
      end
      should "include a value" do
        assert_match(/Value="urn:oasis:names:tc:SAML:2.0:status:Success"/, @status_code.to_xml)
      end
    end
  end
end