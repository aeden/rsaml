require File.dirname(__FILE__) + '/test_helper'

class ConditionsTest < Test::Unit::TestCase
  context "an conditions collection" do
    setup do
      @conditions = Conditions.new
    end
    should "have 0 conditions by default" do
      assert_equal 0, @conditions.conditions.length
      assert_equal 0, @conditions.length
    end
    should "be valid with 0 conditions" do
      assert @conditions.valid?
    end
    should "be cacheable" do
      assert @conditions.cache?
    end
    should "be able to add a condition" do
      @conditions << Condition.new
      assert_equal 1, @conditions.length
    end
  end
end