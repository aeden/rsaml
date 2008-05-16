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
    context "when producing xml" do
      should "produce xml" do
        assert_equal '<NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">example</NameID>', @name.to_xml
      end
      should "optionally include a name qualifier" do
        @name.name_qualifier = 'a_name_qualifier'
        assert_equal '<NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" NameQualifier="a_name_qualifier">example</NameID>', @name.to_xml
      end
      should "optionally include an service provider name qualifier" do
        @name.sp_name_qualifier = 'an_sp_name_qualifier'
        assert_equal '<NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" SPNameQualifier="an_sp_name_qualifier">example</NameID>', @name.to_xml
      end
      should "optionally include an service provider provided id" do
        @name.sp_provided_id = 'sp-x'
        assert_equal '<NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" SPProvidedID="sp-x">example</NameID>', @name.to_xml
      end
    end
  end
end