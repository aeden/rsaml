require File.dirname(__FILE__) + '/test_helper'

class SubjectLocalityTest < Test::Unit::TestCase
  context "a subject locality" do
    setup do
      @subject_locality = SubjectLocality.new
    end
    context "when validating" do
      should "validate the address" do
        @subject_locality.address = 'x'
        assert_raise ValidationError do
          @subject_locality.validate
        end
      end
    end
    context "when producing xml" do
      should "optionally include an address" do
        @subject_locality.address = '1.2.3.4'
        assert_equal '<SubjectLocality Address="1.2.3.4"/>', @subject_locality.to_xml
      end
      should "optionally include a dns name" do
        @subject_locality.dns_name = 'example.com'
        assert_equal '<SubjectLocality DNSName="example.com"/>', @subject_locality.to_xml
      end
    end
  end
end