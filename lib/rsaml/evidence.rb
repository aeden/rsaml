module RSAML #:nodoc:
  # Contains one or more assertions or assertion references that the SAML authority relied 
  # on in issuing the authorization decision.
  class Evidence
    # Specifies an assertion either by reference or by value.
    def assertions
      @assertions ||= []
    end
    
    def validate
      raise ValidationError, "At least one assertion is required" if assertions.empty?
    end
    
    # Construct an XML fragment representing the authentication statement
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('Evidence') {
        assertions.each { |assertion| xml << assertion.to_xml }
      }
    end
  end
end