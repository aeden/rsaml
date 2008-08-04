module RSAML #:nodoc:
  # Contains any additional information that the SAML authority wishes to provide. This information MAY be 
  # ignored by applications without affecting either the semantics or the validity of the assertion.
  class Advice
    include Validatable
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
    
    # Construct an Advice instance from the given XML Element or fragment
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)
      advice = Advice.new
      element.get_elements('saml:Assertion').each do |assertion_element|
        advice.assertions << Assertion.from_xml(assertion_element)
      end
      advice
    end
  end
end