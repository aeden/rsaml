module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Base class for messages. This class should not be instantiated directly, rather the Request and Response
    # classes should be used.
    class Message
      
      # An identifier for the message. It is of type xs:ID and MUST follow the requirements specified in Section 
      # 1.3.4 of the SAML 2.0 specification for identifier uniqueness.
      attr_accessor :id
      
      # The version of this message. The identifier for the version of SAML defined in this specification is "2.0".
      attr_accessor :version
      
      # The time instant of issue of the message. The time value must be encoded in UTC.
      attr_accessor :issue_instant
      
      # A URI reference indicating the address to which this message has been sent. This is useful to prevent 
      # malicious forwarding of messages to unintended recipients, a protection that is required by some 
      # protocol bindings. If it is present, the actual recipient MUST check that the URI reference identifies the 
      # location at which the message was sent or received. If it does not, the response MUST be discarded. Some 
      # protocol bindings may require the use of this attribute.
      attr_accessor :destination
      
      # Indicates whether or not (and under what conditions) consent has been obtained from a principal in 
      # the sending of this message.  If no Consent value is provided, the identifier  
      # urn:oasis:names:tc:SAML:2.0:consent:unspecified is in effect.
      attr_accessor :consent
      
      # Identifies the entity that generated the message.
      attr_accessor :issuer
      
      # An XML Signature that authenticates the requestor or responder and provides message integrity.
      attr_accessor :signature
      
      # Initialize the message instance
      def initialize
        @id = UUID.new.generate
        @version = "2.0"
        @issue_instant = Time.now.utc
      end
      
      # This extension point contains optional protocol message extension elements that are agreed on 
      # between the communicating parties.
      def extensions
        @extionsion ||= []
      end
      
      # Validate the request structure
      def validate
        raise ValidationError, "ID is required" if id.nil?
        raise ValidationError, "Version is required" if version.nil?
        raise ValidationError, "Issue instant is required" if issue_instant.nil?
        raise ValidationError, "Issue instant must be UTC" unless issue_instant.utc?
      end
      
      protected
      # Add XML Namespace attributes
      def add_xmlns(attributes)
        attributes['xmlns:samlp'] = "urn:oasis:names:tc:SAML:2.0:protocol" 
        attributes['xmlns:saml'] = "urn:oasis:names:tc:SAML:2.0:assertion"
        attributes
      end
    end
  end
end