module RSAML #:nodoc:
  # Identifies an attribute by name and optionally includes its value(s).
  class Attribute
    # The name of the attribute.
    attr_accessor :name
    
    # A URI reference representing the classification of the attribute name for purposes of 
    # interpreting the name
    attr_accessor :name_format
    
    # A string that provides a more human-readable form of the attribute's name, which may 
    # be useful in cases in which the actual Name is complex or opaque, such as an OID or a UUID.
    attr_accessor :friendly_name
    
    # Initialize the attribute with the given name. Optionally pass an array of values.
    def initialize(name, *values)
      @name = name
      @values = values      
    end
    
    # An array of values for the attribute.
    def values
      @values ||= []
    end
    
    # Validate the structure of the attribute.
    def validate
      raise ValidationError, "Name is required" unless name
    end
    
    # extension point to allow arbitrary XML attributes to be added to <Attribute> constructs 
    # without the need for an explicit schema extension. This allows additional fields to be 
    # added as needed to supply additional parameters to be used, for example, in an attribute 
    # query.
    def extra_xml_attributes
      @extra_xml_attributes ||= {}
    end
    
    # Construct an XML fragment representing the attribute
    def to_xml(xml=Builder::XmlMarkup.new)
      xml_attributes = {'Name' => name}
      xml_attributes['NameFormat'] = name_format unless name_format.nil?
      xml_attributes['FriendlyName'] = friendly_name unless friendly_name.nil?
      xml.tag!('Attribute', xml_attributes) {
        values.each { |value| xml.tag!('AttributeValue', value.to_s) }
      }
    end
  end
  
  class EncryptedAttribute < Encrypted
    
    # Validate the structure
    def validate
      raise ValidationError, "Encrypted data is required" if encrypted_data.nil?
    end
    
    # Construct an XML fragment representing the encrypted attribute
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('EncryptedAttribute') {
        xml.tag!('EncryptedData', encrypted_data)
        encrypted_keys.each { |key| xml << key.to_xml }
      }
    end
  end
end