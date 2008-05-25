require File.dirname(__FILE__) + '/test_helper'

class AttributeTest < Test::Unit::TestCase
  context "an attribute" do
    setup do
      @attribute = Attribute.new('email')
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
    end
  end
end