module RSAML
  # Specifies the context of an authentication event. The element can contain 
  # an authentication context class reference, an authentication context declaration 
  # or declaration reference, or both.
  class AuthenticationContext
    # A URI reference identifying an authentication context class that describes the authentication context 
    # declaration that follows.
    attr_accessor :class_reference
    
    # Either an authentication context declaration provided by value, or a URI reference that 
    # identifies such a declaration. The URI reference MAY directly resolve into an XML document 
    # containing the referenced declaration.
    attr_accessor :context_declaration
    
    # Zero or more unique identifiers of authentication authorities that were involved in the 
    # authentication of the principal
    def authenticating_authority
      @authenticating_authority ||= []
    end
  end
end