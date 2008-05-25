module RSAML #:nodoc:
  class Advice
    # Contains a mixture of zero or more Assertion, EncryptedAssertion, assertion IDs, and assertion URIs.
    # May also contain custom objects that produce namespace-qualified XML for non-SAML elements.
    def assertions
      @assertions ||= []
    end
    
    # Validate the advice structure.
    def validate
      assertions.each { |assertion| assertion.validate }
    end
    
    # Construct an XML fragment representing the assertion
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:Advice') {
        assertions.each { |assertion| xml << assertion.to_xml }
      }
    end
  end
end