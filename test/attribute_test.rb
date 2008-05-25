require File.dirname(__FILE__) + '/test_helper'

class AttributeTest < Test::Unit::TestCase
  context "an attribute" do
    setup do
      @attribute = Attribute.new('email')
    end
    should "should be valid" do
      assert_nothing_raised do
        @attribute.validate
      end
    end
    should "should not be valid if name is nil" do
      assert_raise ValidationError do
        @attribute.name = nil
        @attribute.validate
      end
    end
    context "when producing xml" do
      should "always include a name attribute" do
        assert_match(/<Attribute Name="email"><\/Attribute>/, @attribute.to_xml)
      end
      should "optionally include a NameFormat attribute" do
        @attribute.name_format = 'http://host/name_format/email'
        assert_match(/NameFormat="#{@attribute.name_format}"/, @attribute.to_xml)
      end
      should "optionally include a FriendlyName attribute" do
        @attribute.friendly_name = 'email'
        assert_match(/FriendlyName="#{@attribute.friendly_name}"/, @attribute.to_xml)
      end
      should "optionally include a single attribute value child element" do
        @attribute.values << 'someone@somewhere.com'
        assert_match(/<AttributeValue>someone@somewhere.com<\/AttributeValue>/, @attribute.to_xml)
      end
      should "optionally include multiple attribute value child elements" do
        @attribute.values << 'someone@somewhere.com'
        @attribute.values << 'someone@somewhereelse.com'
        assert_match(/<AttributeValue>someone@somewhere.com<\/AttributeValue>/, @attribute.to_xml)
        assert_match(/<AttributeValue>someone@somewhereelse.com<\/AttributeValue>/, @attribute.to_xml)
      end
    end
  end
  
  context "an encrypted attribute" do
    setup do
      @encrypted_attribute = EncryptedAttribute.new
    end
    should_eventually "be valid" do
      assert_nothing_raised do
        @encrypted_attribute.validate
      end
    end
    should_eventually "always include encrypted data"
    should_eventually "optionally include encrypted keys"
  end
end