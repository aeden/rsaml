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
    
    def values
      @values ||= []
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