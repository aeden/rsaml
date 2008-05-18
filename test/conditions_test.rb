require File.dirname(__FILE__) + '/test_helper'

class ConditionsTest < Test::Unit::TestCase
  context "an conditions collection" do
    setup do
      @conditions = Conditions.new
    end
    should "have 0 conditions by default" do
      assert_equal 0, @conditions.conditions.length
      assert_equal 0, @conditions.length
    end
    should "be valid with 0 conditions" do
      assert_nothing_raised do
        @conditions.assert
      end
    end
    should "be cacheable" do
      assert @conditions.cache?
    end
    should "be able to add a condition" do
      @conditions << Condition.new
      assert_equal 1, @conditions.length
    end
    
    context "when asserting" do
      should "fail an assertion for NotBefore if that value is in the future" do
        @conditions.not_before = Time.now + 1000
        assert_raise(AssertionError) { @conditions.assert }
      end
      should "fail an assertion for NotOnOrAfter if that value is now" do
        @conditions.not_on_or_after = Time.now
        assert_raise(AssertionError) { @conditions.assert }
      end
      should "fail an assertion for NotOnOrAfter if that value is in the past" do
        @conditions.not_on_or_after = Time.now - 1000
        assert_raise(AssertionError) { @conditions.assert }
      end
      should "assert without error if NotBefore is in the past" do
        @conditions.not_before = Time.now - 1000
        assert_nothing_raised do
          @conditions.assert
        end
      end
      should "assert without error if NotOnOrAfter is in the future" do
        @conditions.not_on_or_after = Time.now + 1000
        assert_nothing_raised do
          @conditions.assert
        end
      end
    end
  
    context "when producing xml" do
      setup do
        @conditions = Conditions.new
      end
      should "optionally include NotBefore attribute" do
        t = @conditions.not_before = Time.now
        assert_equal %Q(<Conditions NotBefore="#{t.xmlschema}"></Conditions>), @conditions.to_xml
      end
      should "optionally include NotOnOrAfter attribute" do
        t = @conditions.not_on_or_after = Time.now
        assert_equal %Q(<Conditions NotOnOrAfter="#{t.xmlschema}"></Conditions>), @conditions.to_xml
      end
      should "optionally include conditions" do
        @conditions << Condition.new
        assert_equal "<Conditions><Condition/></Conditions>", @conditions.to_xml
      end
      should "optionally include audience restriction" do
        audience = Audience.new('http://example.org/audience_terms')
        @conditions.audience_restrictions << audience
        assert_equal "<Conditions><AudienceRestriction><Audience>#{audience.uri}</Audience></AudienceRestriction></Conditions>", @conditions.to_xml
      end
      should "optionally include a proxy restriction" do
        proxy_restriction = ProxyRestriction.new
        @conditions.proxy_restriction = proxy_restriction
        assert_equal "<Conditions><ProxyRestriction></ProxyRestriction></Conditions>", @conditions.to_xml
      end
      should "optionally include a one time use" do
        @conditions.one_time_use = true
        assert_equal "<Conditions><OneTimeUse/></Conditions>", @conditions.to_xml
      end
    end
  end
end