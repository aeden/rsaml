require File.dirname(__FILE__) + '/test_helper'

class AssertionTest < Test::Unit::TestCase
  context "an assertion" do
    setup do
      @issuer = Identifier::Issuer.new('example')
      @assertion = Assertion.new(@issuer)
    end
    should "require version of 2.0" do
      assert_equal "2.0", @assertion.version
    end
    should "require ID" do
      assert_not_nil @assertion.id
    end
    should "require issue instant" do
      assert_not_nil @assertion.issue_instant
    end
    should "require an issuer" do
      assert_not_nil @assertion.issuer
    end
    
    context "with only a subject" do
      setup do
        @assertion.subject = 'test'
      end
      should "be valid" do
        assert_nothing_raised do
          @assertion.validate
        end
      end
    end
    context "with an authentication statement" do
      setup do
        @assertion.statements << AuthenticationStatement.new(AuthenticationContext.new)
      end
      should "require a subject" do
        assert_raise ValidationError do
          @assertion.validate
        end
        assert !@assertion.valid?
      end
    end
    context "with an attribute statement" do
      setup do
        @assertion.statements << AttributeStatement.new
      end
      should "require a subject" do
        assert_raise ValidationError do
          @assertion.validate
        end
      end
    end
    context "with a authorization decision statement" do
      setup do
        @assertion.statements << AuthorizationDecisionStatement.new
      end
      should "require a subject" do
        assert_raise ValidationError do
          @assertion.validate
        end
      end
    end
  
    context "when producing xml" do
      # TODO: implement tests for XML results
      should "always include version, id and issue instant attributes and an issuer child element" do
        xml = @assertion.to_xml
        assert_match(/^<saml:Assertion/, xml)
        assert_match(/Version="2.0"/, xml)
        assert_match(/ID="#{uuid_match}"/, xml)
        assert_match(/IssueInstant="#{date_match}"/, xml)
        assert_match(/<saml:Issuer/, xml)
      end
      should "optionally include a signature" do
        @assertion.signature = XmlSig::Signature.new
        xml = @assertion.to_xml
        assert_match(/<ds:Signature/, xml)
      end
      should "optionally include a subject" do
        @assertion.subject = Subject.new(Identifier::Name.new('The Subject'))
        xml = @assertion.to_xml
        assert_match(%Q(<saml:Subject><saml:NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">The Subject</saml:NameID></saml:Subject>), xml)
      end
      should "optionally include conditions" do
        @assertion.conditions << Condition.new
        xml = @assertion.to_xml
        assert_match(/<saml:Conditions>/, xml)
      end
      should "optionally include advice" do
        uri = 'http://example.com/some_advice'
        advice = Advice.new
        advice.assertions << AssertionIDRef.new(UUID.new.generate)
        advice.assertions << AssertionURIRef.new(uri) # a URI
        @assertion.advice << advice
        xml = @assertion.to_xml
        assert_match(/<saml:Advice><saml:AssertionIDRef>#{uuid_match}<\/saml:AssertionIDRef>/, xml)
        assert_match(/<saml:AssertionURIRef>#{uri}<\/saml:AssertionURIRef><\/saml:Advice>/, xml)
      end
      should "optionally include statements" do
        @assertion.statements << AuthenticationStatement.new(AuthenticationContext.new)
        xml = @assertion.to_xml
        assert_match(/<saml:AuthnStatement AuthnInstant="#{date_match}"/, xml)
      end
    end

    context "when consuming xml" do
      should "return a valid Assertion instance" do
        xml_fragment = %Q(
          <saml:Assertion xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">
            <saml:Issuer>Example</saml:Issuer>
            <saml:Subject>Anthony</saml:Subject>
          </saml:Assertion>
        )
        assertion = Assertion.from_xml(xml_fragment)
        assert_not_nil assertion
        assert_not_nil assertion.issuer
        assert_equal 'Example', assertion.issuer.value
        assert_nothing_raised do
          assertion.validate
        end
      end
      context "where there is no saml:Subject element" do
        should "raise a validation error" do
          xml_fragment = %Q(
            <saml:Assertion xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">
              <saml:Issuer>Example</saml:Issuer>
            </saml:Assertion>
          )
          assertion = Assertion.from_xml(xml_fragment)
          assert_raise ValidationError do
            assertion.validate
          end
        end
      end
    end
  end
  context "an assertion URI ref" do
    setup do
      @assertion_uri_ref = AssertionURIRef.new('some_uri')
    end
    should "provide a uri accessor" do
      assert_equal 'some_uri', @assertion_uri_ref.uri
    end
    context "when validating" do
      should "raise an error if no uri is provided" do
        assert_raise ValidationError do
          @assertion_uri_ref.uri = nil
          @assertion_uri_ref.validate
        end
      end
    end
    context "when producing xml" do
      should "have the uri as the value" do
        assert_match(/<saml:AssertionURIRef>some_uri<\/saml:AssertionURIRef>/, @assertion_uri_ref.to_xml)
      end
    end
    context "when consuming xml" do
      should "return a valid AssertionURIRef instance" do
        assertion_ref = AssertionURIRef.from_xml('<saml:AssertionURIRef xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">some_uri</saml:AssertionURIRef>')
        assert_not_nil assertion_ref
        assert_equal 'some_uri', assertion_ref.uri
        assert assertion_ref.valid?
      end
    end
  end
  context "an assertion ID ref" do
    setup do
      @assertion_id_ref = AssertionIDRef.new('some_id')
    end
    context "when validating" do
      should "raise an error if no id is provided" do
        assert_raise ValidationError do
          @assertion_id_ref.id = nil
          @assertion_id_ref.validate
        end
      end
    end
    context "when producing xml" do
      should "have an id as the value" do
        assert_match(/<saml:AssertionIDRef>some_id<\/saml:AssertionIDRef>/, @assertion_id_ref.to_xml)
      end
    end
    context "when consuming xml" do
      should "return a valid AssertionIDRef instance" do
        assertion_ref = AssertionIDRef.from_xml('<saml:AssertionIDRef xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">some_id</saml:AssertionIDRef>')
        assert_not_nil assertion_ref
        assert_equal 'some_id', assertion_ref.id
        assert assertion_ref.valid?
      end
    end
  end
end