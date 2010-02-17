require File.dirname(__FILE__) + '/test_helper'

class AdviceTest < Test::Unit::TestCase
  context "an advice" do
    setup { @advice = Advice.new }
    should "have 0 assertions by default" do
      assert @advice.assertions.empty?
    end
    should "be valid if all assertions are valid" do
      assert @advice.valid?
    end
    context "when producing xml" do
      should "produce an empty advice tag when there are no assertions" do
        assert_match(/<saml:Advice><\/saml:Advice>/, @advice.to_xml)
      end
    end
    context "when consuming xml" do
      should "return a valid Advice instance" do
        advice = Advice.from_xml('<saml:Advice xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"></saml:Advice>')
        assert_not_nil(advice)
        assert advice.valid?
      end
    end
  end
end