module XmlSig #:nooc:
  class Reference
    attr_accessor :id
    attr_accessor :uri
    attr_accessor :type

    attr_accessor :digest_method

    # DigestValue is an element that contains the encoded value of the digest. The 
    # digest is always encoded using base64
    attr_accessor :digest_value

    def transforms
      @transforms ||= []
    end

    def validate
      raise ValidationError, "Digest method is required" if digest_method.nil?
      raise ValidationError, "Digest value is required" if digest_value.nil?
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Id'] = id unless id.nil?
      attributes['URI'] = uri unless uri.nil?
      attributes['Type'] = type unless type.nil?
      xml.tag!('ds:Reference', attributes) {
        xml.tag!('ds:Transforms') {
          transforms.each { |transform| xml << transform.to_xml }
        }
        xml << digest_method.to_xml unless digest_method.nil?
        xml.tag!('ds:DigestValue', digest_value)
      }
    end
  end

  # DigestMethod is a required element that identifies the digest algorithm to be applied 
  # to the signed object.
  class DigestMethod
    def self.identifiers
      @identifiers ||= {
        'SHA-1', 'http://www.w3.org/2000/09/xmldsig#sha1'
      }
    end
    
    attr_accessor :algorithm

    def validate
      raise ValidationError, "Algorithm is required" if algorithm.nil?
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Algorightm' => algorithm}
      xml.tag!('ds:DigestMethod', attributes)
    end
  end
end