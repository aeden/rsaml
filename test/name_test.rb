require File.dirname(__FILE__) + '/test_helper'

class NameTest < Test::Unit::TestCase
  context "a name" do
    setup do
      @name = Identifier::Name.new('example')
    end
    should "have a value" do
      assert_equal 'example', @name.value
    end
    should "have the unspecified format by default" do
      assert_equal Identifier::Name.formats[:unspecified], @name.format
    end
    context "when producing xml" do
      should "always include format and value" do
        assert_equal '<saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">example</saml:NameID>', @name.to_xml
      end
      should "optionally include a name qualifier" do
        @name.name_qualifier = 'a_name_qualifier'
        assert_equal '<saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" NameQualifier="a_name_qualifier">example</saml:NameID>', @name.to_xml
      end
      should "optionally include an service provider name qualifier" do
        @name.sp_name_qualifier = 'an_sp_name_qualifier'
        assert_equal '<saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" SPNameQualifier="an_sp_name_qualifier">example</saml:NameID>', @name.to_xml
      end
      should "optionally include an service provider provided id" do
        @name.sp_provided_id = 'sp-x'
        assert_equal '<saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified" SPProvidedID="sp-x">example</saml:NameID>', @name.to_xml
      end
    end
  end
end