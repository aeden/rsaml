require File.dirname(__FILE__) + '/test_helper'

class ActionTest < Test::Unit::TestCase
  context "an action" do
    setup do
      @action = Action.new('Read')
    end
    should "have the rwedc_negation namespace by default" do
      assert_equal Action.namespaces[:rwedc_negation], @action.namespace
    end
    context "when producing xml" do
      should "optionally have a namespace" do
        assert_match(/<saml:Action Namespace="#{@action.namespace}"/, @action.to_xml)
      end
    end
  end
end