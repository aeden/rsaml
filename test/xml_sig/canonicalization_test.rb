require File.dirname(__FILE__) + '/../test_helper'

class CanonicalizationTest < Test::Unit::TestCase
  context "a c14n without comments" do
    setup do
      @c14n = XmlSig::XMLC14NWithoutComments.new
    end
    should "convert to UTF-8" do
      assert_equal "Café ñ", @c14n.convert_to_utf8(File.read(File.dirname(__FILE__) + '/iso-8859-1.txt'), 'iso-8859-1')
    end
    should "convert line breaks" do
      assert_equal "line1\nline2\n", @c14n.convert_linebreaks("line1\r\nline2\r")
      assert_equal "\n", @c14n.convert_linebreaks("\n")
      assert_equal "\n", @c14n.convert_linebreaks("\r")
      assert_equal "\n", @c14n.convert_linebreaks("\r\n")
      assert_equal "\n\n", @c14n.convert_linebreaks("\n\n")
    end
  end
end