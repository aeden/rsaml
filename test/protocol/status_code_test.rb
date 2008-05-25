require File.dirname(__FILE__) + '/../test_helper'

class StatusCodeTest < Test::Unit::TestCase
  include RSAML::Protocol
  
  context "the StatusCode class" do
    should "have 4 top level status codes" do
      assert_equal 4, StatusCode.top_level_status_codes.length
    end
  end
end