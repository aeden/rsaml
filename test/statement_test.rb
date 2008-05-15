require File.dirname(__FILE__) + '/test_helper'

class StatementTest < Test::Unit::TestCase
  context "an authentication statement" do
    setup do
      @statement = AuthenticationStatement.new
    end
    should "always have a UTC time for authn_instant" do
      assert_not_nil @statement.authn_instant
      assert @statement.authn_instant.utc?
    end
  end
  context "an attribute statement" do
    setup do
      subject = Subject.new(Name.new('example'))
      @statement = AttributeStatement.new(subject)
    end
  end
end