require File.dirname(__FILE__) + '/../test_helper'

class StatusTest < Test::Unit::TestCase
  include RSAML::Protocol
  
  context "a status instance" do
    setup do
      @status = Status.new(StatusCode::SUCCESS)
    end
    context "when producing xml" do
      should "include a status code" do
        assert_match(%Q(<samlp:StatusCode Value="#{StatusCode::SUCCESS}">), @status.to_xml)
      end
    end
  end
end