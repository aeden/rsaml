require File.dirname(__FILE__) + '/test_helper'

class NameTest < Test::Unit::TestCase
  context "a name" do
    setup do
      @name = Name.new('example')
    end
    should "have a value" do
      assert_equal 'example', @name.value
    end
    should "have the unspecified format by default" do
      assert_equal Name.formats[:unspecified], @name.format
    end
  end
end