require File.dirname(__FILE__) + '/test_helper'

class ActionTest < Test::Unit::TestCase
  context "an action" do
    setup do
      @action = Action.new
    end
    should "have the rwedc_negation namespace by default" do
      assert_equal Action.namespaces[:rwedc_negation], @action.namespace
    end
  end
end