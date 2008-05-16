require File.dirname(__FILE__) + '/test_helper'

class SubjectTest < Test::Unit::TestCase
  context "a subject with an identifier" do
    setup do
      @identifier = Identifier::Name.new('example')
      @subject = Subject.new(@identifier)
    end
    should "have an identifier" do
      assert_equal @identifier, @subject.identifier
    end
    context "when producing xml" do
      should "should include the identifier" do
        assert_equal '<Subject><NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">example</NameID></Subject>', @subject.to_xml
      end
    end
  end
  context "a subject with subject confirmations" do
    setup do
      @subject = Subject.new
      @subject.subject_confirmations << SubjectConfirmation.new(SubjectConfirmation.methods[:holder_of_key])
    end
    
    context "when producing xml" do
      should "optionally include subject confirmations" do
        assert_equal '<Subject><SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:holder-of-key"/></Subject>', @subject.to_xml
      end
    end
  end
  
  context "a subject with an identifier and subject confirmations" do
    setup do
      @identifier = Identifier::Name.new('example')
      @subject = Subject.new(@identifier)
      @subject.subject_confirmations << SubjectConfirmation.new(SubjectConfirmation.methods[:holder_of_key])
    end
    
    context "when producing xml" do
      should "include the identifier followed by the subject confirmations" do
        assert_equal '<Subject><NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">example</NameID><SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:holder-of-key"/></Subject>', @subject.to_xml
      end
    end
  end
end