require File.dirname(__FILE__) + '/test_helper'

class StatementTest < Test::Unit::TestCase
  context "an authentication statement" do
    setup do
      @statement = Authentication.new
    end
    should "always have a UTC time for authn_instant" do
      assert_not_nil @statement.authn_instant
      assert @statement.authn_instant.utc?
    end
  end
end