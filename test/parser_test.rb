require File.dirname(__FILE__) + '/test_helper'

class ParserTest < Test::Unit::TestCase
  context "a parser" do
    setup { @parser = Parser.new }
    context "parsing an attribute query message" do
      setup do
        @attribute_query = @parser.parse(attribute_query_xml)
      end
      should "return an attribute query instance" do
        assert @attribute_query.is_a?(Protocol::Query::AttributeQuery)
      end
      should "have 1 attribute" do
        assert_equal 1, @attribute_query.attributes.length
      end
      should "have a subject of Anthony Eden" do
        assert_equal 'Anthony Eden', @attribute_query.subject.identifier.value
      end
      should "have an attribute whose name is Name" do
        assert_equal 'Name', @attribute_query.attributes.first.name
      end
    end
  end
  
  def attribute_query_xml
    @attribute_query_xml ||= begin
      open(File.dirname(__FILE__) + '/sample_data/attribute_query.xml') do |f|
        f.read
      end
    end
  end
end