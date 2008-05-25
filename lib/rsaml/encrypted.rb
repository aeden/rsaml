module RSAML #:nodoc:
  # Base for encrypted elements
  class Encrypted
    # Encrypted data
    attr_accessor :encrypted_data
    
    # Encrypted keys
    def encrypted_keys
      @encrypted_keys ||= []
    end
  end
end