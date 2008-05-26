module XmlSig #:nodoc:
  # SignatureMethod is a required element that specifies the algorithm used for 
  # signature generation and validation. This algorithm identifies all cryptographic 
  # functions involved in the signature operation (e.g. hashing, public key 
  # algorithms, MACs, padding, etc.).
  class SignatureMethod
    attr_accessor :algorithm

    def validate
      raise ValidationError, "Algorithm is required" if algorithm.nil?
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Algorightm' => algorithm}
      xml.tag!('ds:SignatureMethod', attributes) {
        xml.tag!('ds:HMACOutputLength', hmac_output_length) unless hmac_output_length.nil?
      }
    end
  end
end