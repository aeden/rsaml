require File.dirname(__FILE__) + '/../test_helper'

class RequestTest < Test::Unit::TestCase
  context "a request instance" do
    setup do
      @request = Protocol::Request.new(UUID.new)
    end
    should "require an id" do
      @request.id = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require a version" do
      @request.version = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require an issue instant" do
      @request.issue_instant = nil
      assert_raise ValidationError do
        @request.validate
      end
    end
    should "require an issue instant to be UTC" do
      @request.issue_instant = Time.now
      assert_raise ValidationError do
        @request.validate
      end
    end
    context "when producing xml" do
      should "include the samlp:Request element" do
        assert_match('<samlp:Request', @request.to_xml)
      end
      should "require include required attributes" do
        xml = @request.to_xml
        assert_match(/ID="#{@request.id}"/, xml)
        assert_match(/Version="2.0"/, xml)
        assert_match(/IssueInstant="#{date_match}"/, xml)
      end
      should "optionally include a destination" do
        @request.destination = 'http://somesite/destination'
        assert_match(/Destination="#{@request.destination}"/, @request.to_xml)
      end
      should "optionally include a consent" do
        @request.consent = 'http://somesite/consent'
        assert_match(/Consent="#{@request.consent}"/, @request.to_xml)
      end
      should "optionally include an issuer child element" do
        @request.issuer = Identifier::Issuer.new('example')
        assert_match(%Q(<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">example</saml:Issuer>), @request.to_xml)
      end
      should "optionally include a signature" do
        @request.signature = Signature.new()
        assert_match(%Q(<ds:Signature), @request.to_xml)
      end
    end
  end
end