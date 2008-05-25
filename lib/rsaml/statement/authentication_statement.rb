module RSAML #:nodoc:
  module Statement #:nodoc:
    # The assertion subject was authenticated by a particular means at a particular time.
    class AuthenticationStatement < Base
      # Specifies the time at which the authentication took place. The time value is encoded in UTC
      attr_accessor :authn_instant
    
      # Specifies the index of a particular session between the principal identified by the subject and the 
      # authenticating authority. In general, any string value MAY be used as a SessionIndex value. 
      # However, when privacy is a consideration, care must be taken to ensure that the SessionIndex 
      # value does not invalidate other privacy mechanisms. Accordingly, the value SHOULD NOT be usable 
      # to correlate activity by a principal across different session participants.
      attr_accessor :session_index
    
      # Specifies a time instant at which the session between the principal identified by the subject and the 
      # SAML authority issuing this statement MUST be considered ended. The time value is encoded in 
      # UTCSpecifies
      attr_accessor :session_not_on_or_after
    
      # Specifies the DNS domain name and IP address for the system from which the assertion subject was 
      # apparently authenticated.
      attr_accessor :subject_locality
    
      # The authentication context.
      attr_accessor :authn_context
    
      # Initialize the statement
      def initialize(authn_context)
        @authn_context = authn_context
        @authn_instant = Time.now.utc
      end
      
      # Validate the structure of the authentication statement. Raise a ValidationError if the 
      # statement is invalid.
      def validate
        if session_not_on_or_after && !session_not_on_or_after.utc?
          raise ValidationError, "Session not on or after must be UTC"
        end
        raise ValidationError, "Authn context required" unless authn_context
        raise ValidationError, "Authn instant required" unless authn_instant
        raise ValidationError, "Authn instant must be UTC" unless authn_instant.utc?
      end
      
      # Construct an XML fragment representing the authentication statement
      def to_xml(xml=Builder::XmlMarkup.new)
        validate
        attributes = {'AuthnInstant' => authn_instant.xmlschema}
        attributes['SessionIndex'] = session_index unless session_index.nil?
        attributes['SessionNotOnOrAfter'] = session_not_on_or_after.xmlschema unless session_not_on_or_after.nil?
        xml.tag!('saml:AuthnStatement', attributes) {
          xml << authn_context.to_xml
          xml << subject_locality.to_xml unless subject_locality.nil?
        }
      end
    end
  end
end