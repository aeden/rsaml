require File.dirname(__FILE__) + '/test_helper'

class ActionTest < Test::Unit::TestCase
  context "an action" do
    setup do
      @action = Action.new('Read')
    end
    should "have the rwedc_negation namespace by default" do
      assert_equal Action.namespaces[:rwedc_negation], @action.namespace
    end
    should "be valid by default" do
      assert @action.valid?
    end
    context "when producing xml" do
      should "optionally have a namespace" do
        assert_match(/<saml:Action Namespace="#{@action.namespace}"/, @action.to_xml)
      end
    end
    context "when consuming xml" do
      should "return a valid Action instance" do
        action = Action.from_xml('<saml:Action>Read</saml:Action>')
        assert_not_nil(action)
        assert_equal 'Read', action.value
        assert_equal Action.namespaces[:rwedc_negation], action.namespace
        assert action.valid?
      end
      context "with an action namespace attribute" do
        should "return a valid Action instance with an action namespace" do
          action = Action.from_xml(%Q(<saml:Action Namespace="#{Action.namespaces[:rwedc]}">Write</saml:Action>))
          assert_not_nil(action)
          assert_equal 'Write', action.value
          assert_equal Action.namespaces[:rwedc], action.namespace
        end
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