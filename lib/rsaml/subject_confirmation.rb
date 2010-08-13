module RSAML #:nodoc:
  # Provides the means for a relying party to verify the correspondence of the subject of the 
  # assertion with the party with whom the relying party is communicating.
  class SubjectConfirmation
    
    # Hash of available SAML methods for subject confirmation
    def self.methods
      {
        :holder_of_key => 'urn:oasis:names:tc:SAML:2.0:cm:holder-of-key',
        :sender_vouches => 'urn:oasis:names:tc:SAML:2.0:cm:sender-vouches',
        :bearer => 'urn:oasis:names:tc:SAML:2.0:cm:bearer'
      }
    end
    
    # A URI reference that identifies a protocol or mechanism to be used to confirm the subject.
    attr_accessor :method
    
    # Identifies the entity expected to satisfy the enclosing subject confirmation requirements.
    attr_accessor :identifier
    
    # Additional confirmation information to be used by a specific confirmation method.
    attr_accessor :subject_confirmation_data
    
    def initialize(method)
      @method = method
    end
    
    # Construct an XML fragment representing the subject confirmation
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Method' => method}
      xml.tag!('saml:SubjectConfirmation', attributes) {
        xml << subject_confirmation_data.to_xml unless subject_confirmation_data.nil?
      }
    end
  end
end
