require File.dirname(__FILE__) + '/test_helper'

class ActionNamespaceTest < Test::Unit::TestCase
  context "the rwdec namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:rwedc]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:rwedc', @action_namespace.uri
    end
    should "have the correct actions" do
      assert_equal [
        'Read','Write','Execute','Delete','Control'
      ], @action_namespace.action_names
    end
  end
  context "the rwdec-negation namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:rwedc_negation]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:rwedc-negation', @action_namespace.uri
    end
    should "have the correct actions" do
      assert_equal [
        'Read','Write','Execute','Delete','Control',
        '~Read','~Write','~Execute','~Delete','~Control'
      ], @action_namespace.action_names
    end
  end
  context "the ghpp namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:ghpp]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:ghpp', @action_namespace.uri
    end
    should "have the correct actions" do
      assert_equal [
        'Get','Head','Put','Post'
      ], @action_namespace.action_names
    end
  end
  context "the unix file permissions namespace" do
    setup do
      @action_namespace = ActionNamespace.namespaces[:unix]
    end
    should "have the correct uri" do
      assert_equal 'urn:oasis:names:tc:SAML:1.0:action:unix', @action_namespace.uri
    end
    should_eventually "have the correct actions"
  end
end