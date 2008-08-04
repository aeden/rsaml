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
  end
end