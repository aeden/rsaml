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
        @assertion.statements << AuthenticationStatement.new
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
        assert_match(/^<Assertion/, xml)
        assert_match(/Version="2.0"/, xml)
        assert_match(/ID="#{uuid_match}"/, xml)
        assert_match(/IssueInstant="#{date_match}"/, xml)
        assert_match(/<Issuer/, xml)
      end
      should "optionally include a signature" do
        @assertion.signature = Signature.new
        xml = @assertion.to_xml
        assert_match(/<ds:Signature/, xml)
      end
      should "optionally include a subject" do
        @assertion.subject = Subject.new(Identifier::Name.new('The Subject'))
        xml = @assertion.to_xml
        assert_match(%Q(<Subject><NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified">The Subject</NameID></Subject>), xml)
      end
      should "optionally include conditions" do
        @assertion.conditions << Condition.new
        xml = @assertion.to_xml
        assert_match(/<Conditions>/, xml)
      end
      should "optionally include advice" do
        uri = 'http://example.com/some_advice'
        advice = Advice.new
        advice.assertions << AssertionIDRef.new(UUID.new)
        advice.assertions << AssertionURIRef.new(uri) # a URI
        @assertion.advice << advice
        xml = @assertion.to_xml
        assert_match(/<Advice><AssertionIDRef>#{uuid_match}<\/AssertionIDRef>/, xml)
        assert_match(/<AssertionURIRef>#{uri}<\/AssertionURIRef><\/Advice>/, xml)
      end
      should_eventually "optionally include statements"
    end
  end
end