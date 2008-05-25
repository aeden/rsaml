module RSAML #:nodoc:
  # Specifies the context of an authentication event. The element can contain 
  # an authentication context class reference, an authentication context declaration 
  # or declaration reference, or both.
  class AuthenticationContext
    # A URI reference identifying an authentication context class that describes the authentication context 
    # declaration that follows.
    attr_accessor :class_reference
    
    # An authentication context declaration provided by value.
    attr_accessor :context_declaration
    
    # A URI reference that identifies a declaration. The URI reference MAY directly resolve into 
    # an XML document containing the referenced declaration.
    attr_accessor :context_declaration_ref
    
    # Zero or more unique identifiers of authentication authorities that were involved in the 
    # authentication of the principal
    def authenticating_authority
      @authenticating_authority ||= []
    end
    
    # Construct an XML fragment representing the authentication statement
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:AuthnContext') {
        xml.tag!('saml:AuthnContextClassRef', class_reference) unless class_reference.nil?
        xml.tag!('saml:AuthnContextDecl', context_declaration) unless context_declaration.nil?
        xml.tag!('saml:AuthnContextDeclRef', context_declaration_ref) unless context_declaration_ref.nil?
      }
    end
  end
end

require 'rsaml/authn_context/authentication_context_declaration'