module XmlSig #:nodoc:
  # An XML signature.
  class Signature
    attr_accessor :id
    attr_accessor :signed_info
    attr_accessor :signature_value
    attr_accessor :key_info

    def objects
      @objects ||= []
    end

    def assert
      # raise AssertionError, "An assertion signature must be valid"
    end

    # Construct an XML fragment representing the signature
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Id'] = id unless id.nil?
      attributes['xmlns:ds'] = "http://www.w3.org/2000/09/xmldsig#"
      xml.tag!('ds:Signature', attributes) {
        xml << signed_info.to_xml if signed_info
        xml.tag!('ds:SignatureValue')
        xml.tag!('ds:KeyInfo') if key_info
      }
    end
  end
end