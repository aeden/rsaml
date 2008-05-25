module RSAML #:nodoc:
  # An XML signature.
  class Signature 
    def assert
      # raise AssertionError, "An assertion signature must be valid"
    end
    
    # Construct an XML fragment representing the signature
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      xml.tag!('ds:Signature', attributes)
    end
  end
end