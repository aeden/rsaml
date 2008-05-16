require File.dirname(__FILE__) + '/test_helper'

class IdentifierTest < Test::Unit::TestCase
  context "an identifier" do
    setup do
      @identifier = Identifier::Base.new
    end
    context "when producing xml" do
      should "always include value" do
        assert_equal '<BaseID></BaseID>', @identifier.to_xml
      end
      should "optionally include a name qualifier" do
        @identifier.name_qualifier = 'a_name_qualifier'
        assert_equal '<BaseID NameQualifier="a_name_qualifier"></BaseID>', @identifier.to_xml
      end
      should "optionally include an service provider name qualifier" do
        @identifier.sp_name_qualifier = 'an_sp_name_qualifier'
        assert_equal '<BaseID SPNameQualifier="an_sp_name_qualifier"></BaseID>', @identifier.to_xml
      end
    end
  end
end