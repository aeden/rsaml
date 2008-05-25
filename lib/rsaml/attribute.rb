module RSAML
  class Attribute
    # The name of the attribute.
    attr_accessor :name
    
    # A URI reference representing the classification of the attribute name for purposes of 
    # interpreting the name
    attr_accessor :name_format
    
    # A string that provides a more human-readable form of the attribute's name, which may 
    # be useful in cases in which the actual Name is complex or opaque, such as an OID or a UUID.
    attr_accessor :friendly_name
    
    def initialize(name)
      @name = name
    end
    
    def values
      @values ||= []
    end
    
    def validate
      raise ValidationError, "Name is required" unless name
    end
    
    # Construct an XML fragment representing the authentication statement
    def to_xml(xml=Builder::XmlMarkup.new)
      xml_attributes = {'Name' => name}
      xml_attributes['NameFormat'] = name_format unless name_format.nil?
      xml_attributes['FriendlyName'] = friendly_name unless friendly_name.nil?
      xml.tag!('Attribute', xml_attributes) {
        values.each { |value| xml.tag!('AttributeValue', value.to_s) }
      }
    end
  end
  
  class EncryptedAttribute
    # Encrypted data
    attr_accessor :encrypted_data
    
    # Encrypted keys
    def encrypted_keys
      @encrypted_keys ||= []
    end
  end
end