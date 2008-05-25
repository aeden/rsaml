module RSAML #:nodoc:
  module Identifier #:nodoc:
    # A Name identifier.
    class Name < Base
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
    
      # The value of the identifier
      attr_accessor :value
    
      # Initialize the identifier with the given value
      def initialize(value)
        @value = value
      end
    
      # The format of the name.
      def format
        @format ||= Name.formats[:unspecified]
      end
    
      # Construct an XML fragment representing the name
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Format' => format}
        attributes['NameQualifier'] = name_qualifier unless name_qualifier.nil?
        attributes['SPNameQualifier'] = sp_name_qualifier unless sp_name_qualifier.nil?
        attributes['SPProvidedID'] = sp_provided_id unless sp_provided_id.nil?
        xml.tag!('saml:NameID', value, attributes)
      end
    
    end
  end
end