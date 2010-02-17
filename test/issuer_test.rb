require File.dirname(__FILE__) + '/test_helper'

class IssuerTest < Test::Unit::TestCase
  context "a name" do
    setup do
      @identifier = Identifier::Issuer.new('Some Issuer')
    end
    should "have a value" do
      assert_equal 'Some Issuer', @identifier.value
    end
    should "have the entity format by default" do
      assert_equal Identifier::Name.formats[:entity], @identifier.format
    end
    context "when producing xml" do
      should "always include format and value" do
        assert @identifier.to_xml.include? 'Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity"'
        assert @identifier.to_xml.include? 'Some Issuer'
      end
      should "optionally include a name qualifier" do
        @identifier.name_qualifier = 'a_name_qualifier'
        assert @identifier.to_xml.include? 'NameQualifier="a_name_qualifier"'
      end
      should "optionally include an service provider name qualifier" do
        @identifier.sp_name_qualifier = 'an_sp_name_qualifier'
        assert_equal '<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity" SPNameQualifier="an_sp_name_qualifier">Some Issuer</saml:Issuer>', @identifier.to_xml
      end
      should "optionally include an service provider provided id" do
        @identifier.sp_provided_id = 'sp-x'
        assert_equal '<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity" SPProvidedID="sp-x">Some Issuer</saml:Issuer>', @identifier.to_xml
      end
    end
  end
end