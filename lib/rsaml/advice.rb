module RSAML
  class Advice
    # Contains a mixture of zero or more Assertion, EncryptedAssertion, assertion IDs, and assertion URIs.
    # May also contain custom objects that produce namespace-qualified XML for non-SAML elements.
    def assertions
      @assertions ||= []
    end
    
    # Construct an XML fragment representing the assertion
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('Advice') {
        assertions.each { |assertion| xml << assertion.to_xml }
      }
    end
  end
end