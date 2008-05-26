module XmlSig #:nodoc:
  class SignedInfo
    attr_accessor :id
    attr_accessor :canonicalization_method
    attr_accessor :signature_method

    def references
      @references ||= []
    end

    def validate
      raise ValidationError, "Canonicalization method is required" if canonicalization_method.nil?
      raise ValidationError, "Signature method is required" if signature_method.nil?
      raise ValidationError, "At least one reference is required" if references.empty?
    end

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Id'] = id unless id.nil?
      xml.tag!('ds:SignedInfo', attributes) {
        xml << canonicalization_method.to_xml unless canonicalization_method.nil?
        xml << signature_method.to_xml unless signature_method.nil?
        references.each { |reference| xml << reference.to_xml }
      }
    end
  end
end