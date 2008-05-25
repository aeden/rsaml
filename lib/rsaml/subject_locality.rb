module RSAML #:nodoc:
  # This element is entirely advisory, since both of these fields are quite easily “spoofed,” 
  # but may be useful information in some applications.
  class SubjectLocality
    # The network address of the system from which the principal identified by the subject was 
    # authenticated.
    attr_accessor :address
    
    # The DNS name of the system from which the principal identified by the subject was authenticated.
    attr_accessor :dns_name
    
    # Raise an error if the subject locality is structurally invalid.
    def validate
      unless address =~ /^(\d{1,3}\.){3}\d{1,3}$/
        raise ValidationError, "Invalid address"
      end
    end
    
    # Construct an XML fragment representing the subject locality
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Address'] = address unless address.nil?
      attributes['DNSName'] = dns_name unless dns_name.nil?
      xml.tag!('SubjectLocality', attributes)
    end
  end
end