require File.dirname(__FILE__) + '/test_helper'

class EncryptedIdTest < Test::Unit::TestCase
  context "an encrypted id" do
    setup do
      @encrypted_id = EncryptedId.new
    end
    should "have 0 encrypted keys initially" do
      assert_equal 0, @encrypted_id.encrypted_keys.length
    end
  end
end