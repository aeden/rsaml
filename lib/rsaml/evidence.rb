module RSAML
  class Evidence
    # Specifies an assertion by reference to the value of the assertion’s ID attribute.
    def assertion_id_refs
      @assertion_id_refs ||= []
    end
    
    # Specifies an assertion by means of a URI reference.
    def assertion_uri_refs
      @assertion_uri_refs ||= []
    end
    
    # Specifies an assertion by value.
    def assertions
      @assertions ||= []
    end
    
    # Specifies an encrypted assertion by value.
    def encrypted_assertions
      @encrypted_assertions ||= []
    end
  end
end