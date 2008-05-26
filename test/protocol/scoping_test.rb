require File.dirname(__FILE__) + '/../test_helper'

class ScopingTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "a scoping instance" do
    setup do
      @scoping = Scoping.new
    end
    context "when producing xml" do
      should "optionally include a proxy count" do
        @scoping.proxy_count = 2
        assert_match '<samlp:Scoping ProxyCount="2"', @scoping.to_xml
      end
      should "optionally include an idp list" do
        @scoping.idp_list = IDPList.new(IDPEntry.new('some_provider_id'))
        assert_match '<samlp:IDPList><samlp:IDPEntry', @scoping.to_xml
      end
    end
  end
end