require File.dirname(__FILE__) + '/test_helper'

class AssertionTest < Test::Unit::TestCase
  context "an assertion" do
    setup do
      @assertion = Assertion.new
    end
    should "require version of 2.0" do
      assert_equal "2.0", @assertion.version
    end
    should "require ID" do
      assert_not_nil @assertion.id
    end
    should "require issue instant" do
      assert_not_nil @assertion.issue_instant
    end
  end
end