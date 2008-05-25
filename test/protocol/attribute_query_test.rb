require File.dirname(__FILE__) + '/../test_helper'

class AttributeQueryTest < Test::Unit::TestCase
  include RSAML::Protocol
  
  context "an attribute query" do
    setup do
      @query = AttributeQuery.new(Subject.new('example'))
    end
    context "with attributes" do
      setup do
        @query.attributes << Attribute.new('email')
      end
      should "be valid" do
        assert_nothing_raised { @query.validate }
      end
      should "not allow duplicate attributes" do
        @query.attributes << Attribute.new('email')
        assert_raise ValidationError do
          @query.validate
        end
      end
    end
    context "when producing xml" do
      should "include a subject" do
        assert_match('<saml:Subject>example</saml:Subject>', @query.to_xml)
      end
    end
  end
end