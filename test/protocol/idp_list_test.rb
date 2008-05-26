require File.dirname(__FILE__) + '/../test_helper'

class IDPListTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "an idp list" do
    setup do
      @idp_list = IDPList.new
    end
    context "when producing xml" do
      should "have the IDPList element" do
        assert_match('<samlp:IDPList', @idp_list.to_xml)
      end
    end
  end
end