module RSAML #:nodoc
  # Base class for conditions
  class Condition
    # Assert that the condition evaluates to true, raise an AssertionError if not
    def assert
    end
    
    # Construct an XML fragment representing the condition
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:Condition')
    end
  end
end