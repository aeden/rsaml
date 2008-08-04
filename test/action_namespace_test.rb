require File.dirname(__FILE__) + '/test_helper'

class ActionNamespaceTest < Test::Unit::TestCase
  context "the ActionNamespace class" do
    should "define all of the namespaces in the SAML 2.0 specification" do
      namespace_uris = ActionNamespace.namespaces.values.collect { |ns| ns.uri }
      assert namespace_uris.include?('urn:oasis:names:tc:SAML:1.0:action:rwedc')
      assert namespace_uris.include?('urn:oasis:names:tc:SAML:1.0:action:rwedc-negation')
      assert namespace_uris.include?('urn:oasis:names:tc:SAML:1.0:action:ghpp')
      assert namespace_uris.include?('urn:oasis:names:tc:SAML:1.0:action:unix')
    end
  end
  context "the rwdec namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:rwedc]
      @expected_actions = ['Read','Write','Execute','Delete','Control']
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:rwedc', @action_namespace.uri
    end
    should "return the uri when to_s is invoked" do
      assert_equal @action_namespace.uri, @action_namespace.to_s
    end
    should "have the correct actions" do
      assert_equal @expected_actions, @action_namespace.action_names
    end
    should "return true for a valid action" do
      @expected_actions.each do |action|
        assert @action_namespace.valid_action?(action)
      end
    end
    should "return false for an invalid action" do
      assert_equal false, @action_namespace.valid_action?('invalid-action')
    end
  end
  context "the rwdec-negation namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:rwedc_negation]
      @expected_actions = [
        'Read','Write','Execute','Delete','Control',
        '~Read','~Write','~Execute','~Delete','~Control'
      ]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:rwedc-negation', @action_namespace.uri
    end
    should "have the correct actions" do
      assert_equal @expected_actions, @action_namespace.action_names
    end
    should "return true for a valid action" do
      @expected_actions.each do |action|
        assert @action_namespace.valid_action?(action)
      end
    end
    should "return false for an invalid action" do
      assert_equal false, @action_namespace.valid_action?('invalid-action')
    end
  end
  context "the ghpp namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:ghpp]
      @expected_actions = ['GET','HEAD','PUT','POST']
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:ghpp', @action_namespace.uri
    end
    should "have the correct actions" do
      assert_equal @expected_actions, @action_namespace.action_names
    end
    should "return false for an invalid action" do
      assert_equal false, @action_namespace.valid_action?('invalid-action')
    end
  end
  context "the unix file permissions namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:unix]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:unix', @action_namespace.uri
    end
    should_eventually "have the correct actions" do
      
    end
  end
end