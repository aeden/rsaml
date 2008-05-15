require File.dirname(__FILE__) + '/test_helper'

class AssertionTest < Test::Unit::TestCase
  context "an assertion" do
    setup do
      issuer = Name.new('example')
      @assertion = Assertion.new(issuer)
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
    should "require an issuer" do
      assert_not_nil @assertion.issuer
    end
    
    context "with only a subject" do
      setup do
        @assertion.subject = 'test'
      end
      should "be valid" do
        assert_nothing_raised do
          @assertion.validate
        end
      end
    end
    context "with an authentication statement" do
      setup do
        @assertion.statements << AuthenticationStatement.new
      end
      should "require a subject" do
        assert_raise ValidationError do
          @assertion.validate
        end
      end
    end
    context "with an attribute statement" do
      setup do
        @assertion.statements << AttributeStatement.new
      end
      should "require a subject" do
        assert_raise ValidationError do
          @assertion.validate
        end
      end
    end
  end
end