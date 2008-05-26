require File.dirname(__FILE__) + '/../test_helper'

class ResponseTest < Test::Unit::TestCase
  include RSAML::Protocol
  context "a response instance" do
    setup do
      @response = Response.new(Status.new(StatusCode::SUCCESS))
    end
    should "require an id" do
      @response.id = nil
      assert_raise ValidationError do
        @response.validate
      end
    end
    should "require a version" do
      @response.version = nil
      assert_raise ValidationError do
        @response.validate
      end
    end
    should "require an issue instant" do
      @response.issue_instant = nil
      assert_raise ValidationError do
        @response.validate
      end
    end
    should "require an issue instant to be UTC" do
      @response.issue_instant = Time.now
      assert_raise ValidationError do
        @response.validate
      end
    end
    should "be valid" do
      assert_nothing_raised { @response.validate }
    end
    context "when producing xml" do
      should "include the samlp:Response element" do
        assert_match('<samlp:Response', @response.to_xml)
      end
      should "require include required attributes" do
        xml = @response.to_xml
        assert_match(/ID="#{@response.id}"/, xml)
        assert_match(/Version="2.0"/, xml)
        assert_match(/IssueInstant="#{date_match}"/, xml)
      end
      should "optionally include an InResponseTo attribute" do
        @response.in_response_to = 'some_id'
        assert_match(/InResponseTo="some_id"/, @response.to_xml)
      end
      should "optionally include a destination" do
        @response.destination = 'http://somesite/destination'
        assert_match(/Destination="#{@response.destination}"/, @response.to_xml)
      end
      should "optionally include a consent" do
        @response.consent = 'http://somesite/consent'
        assert_match(/Consent="#{@response.consent}"/, @response.to_xml)
      end
      should "optionally include an issuer child element" do
        @response.issuer = Identifier::Issuer.new('example')
        assert_match(%Q(<saml:Issuer Format="urn:oasis:names:tc:SAML:2.0:nameid-format:entity">example</saml:Issuer>), @response.to_xml)
      end
      should "optionally include a signature" do
        @response.signature = XmlSig::Signature.new()
        assert_match(%Q(<ds:Signature), @response.to_xml)
      end
    end
  end
end