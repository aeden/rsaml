module RSAML
  class Identifier
    # The security or administrative domain that qualifies the name. This attribute provides a means to 
    # federate names from disparate user stores without collision.
    attr_accessor :name_qualifier
    
    # Further qualifies a name with the name of a service provider or affiliation of providers. This 
    # attribute provides an additional means to federate names on the basis of the relying party or 
    # parties.
    attr_accessor :sp_name_qualifier
    
    # The value of the identifier
    attr_accessor :value
    
    def initialize(value)
      @value = value
    end
  end
  
  class Name < Identifier
    # The following identifiers MAY be used to refer to the classification of the attribute name 
    # for purposes of interpreting the name.
    def self.formats
      {
        :unspecified => 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified',
        :email_address => 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
        :x509_subject_name => 'urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName',
        :windows_domain_qualified_name => 'urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName',
        :kerberos => 'urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos',
        :entity => 'urn:oasis:names:tc:SAML:2.0:nameid-format:entity',
        :persistent => 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
        :transient => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient'
      }
    end
    
    # A URI reference representing the classification of string-based identifier information.
    attr_accessor :format
    
    # A name identifier established by a service provider or affiliation of providers for the entity, if 
    # different from the primary name identifier given
    attr_accessor :sp_provided_id
    
  end
end