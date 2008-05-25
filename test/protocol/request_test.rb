require File.dirname(__FILE__) + '/../test_helper'

class RequestTest < Test::Unit::TestCase
  context "a request instance" do
    setup do
      @request = Protocol::Request.new(UUID.new)
    end
    should "require an id" do
      @request.id = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require a version" do
      @request.version = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require an issue instant" do
      @request.issue_instant = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require an issue instant to be UTC" do
      @request.issue_instant = Time.now
      assert_raise ValidationError do
        @request.validate
      end
    end
    context "when producing xml" do
      
    end
  end
end