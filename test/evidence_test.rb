require File.dirname(__FILE__) + '/test_helper'

class EvidenceTest < Test::Unit::TestCase
  context "an evidence instance" do
    setup do 
      @evidence = Evidence.new
    end
    should "not be valid unless at least one assertion is specified" do
      assert_raise ValidationError do
        @evidence.validate
      end
    end
    
    context "when producing xml" do
      should "optionally include an assertion id ref" do
        @evidence.assertions << AssertionIDRef.new('149369035468035')
        assert_match(/<Evidence><AssertionIDRef>149369035468035<\/AssertionIDRef><\/Evidence>/, @evidence.to_xml)
      end
      should "optionally include an assertion uri ref" do
        @evidence.assertions << AssertionURIRef.new('http://xyz.com/assertion/uri')
        assert_match(/<Evidence><AssertionURIRef>http:\/\/xyz.com\/assertion\/uri<\/AssertionURIRef><\/Evidence>/, @evidence.to_xml)
      end
      should "optionally include an assertion" do
        @evidence.assertions << Assertion.new(Identifier::Issuer.new('example'))
        assert_match(/<Evidence><Assertion /, @evidence.to_xml)
      end
      should_eventually "optionally include an encrypted assertion"
    end
  end
end