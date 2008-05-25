require File.dirname(__FILE__) + '/test_helper'

class StatementTest < Test::Unit::TestCase
  context "an authentication statement" do
    setup do
      @statement = AuthenticationStatement.new(AuthenticationContext.new())
    end
    should "always have a UTC time for authn_instant" do
      assert_not_nil @statement.authn_instant
      assert @statement.authn_instant.utc?
    end
    should "be valid" do
      assert_nothing_raised do
        @statement.validate
      end
    end
    should "be invalid if authn_instant is not UTC" do
      @statement.authn_instant = Time.now
      assert_raise ValidationError do
        @statement.validate
      end
    end
    context "when producing xml" do
      should "always include authn_instant" do
        assert_match(/<AuthnStatement AuthnInstant="#{date_match}">/, @statement.to_xml)
      end
      should "always include authn_context" do
        assert_match(/<AuthnContext>/, @statement.to_xml)
      end
      should "optionally include a session index" do
        @statement.session_index = '12345'
        assert_match(/SessionIndex="\d+"/, @statement.to_xml)
      end
      should "optionally include a session not on or after date" do
        @statement.session_not_on_or_after = (Time.now + 5.days).utc
        assert_match(/SessionNotOnOrAfter="#{date_match}"/, @statement.to_xml)
      end
    end
  end
  context "an attribute statement" do
    setup do
      @statement = AttributeStatement.new
      @statement.attributes << Attribute.new('email', 'someone@someplace.com')
    end
    should "be valid" do
      assert_nothing_raised { @statement.validate }
    end
    should "not be valid if empty attributes" do
      assert_raise ValidationError do
        @statement.attributes.clear
        @statement.validate
      end
    end
    context "when producing xml" do
      should "include at least on attribute" do
        assert_match(/<AttributeStatement><Attribute Name="email"><AttributeValue>someone@someplace.com<\/AttributeValue><\/Attribute><\/AttributeStatement>/, @statement.to_xml)
      end
    end
  end
  
  context "an authorization decision statement" do
    
  end
end