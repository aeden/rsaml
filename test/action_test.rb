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
    context "when validating" do
      should "raise an error if no value is provided" do
        assert_raise ValidationError do
          @action.value = nil
          @action.validate
        end
      end
      should "raise an error if the value is not in the specified namespace" do
        assert_raise ValidationError do
          @action.value = 'PUT'
          @action.validate
        end
      end
    end
  end
end