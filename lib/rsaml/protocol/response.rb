module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML response
    class Response
      # An identifier for the response. It is of type xs:ID and MUST follow the requirements specified in Section 
      # 1.3.4 of the SAML 2.0 specification for identifier uniqueness.
      attr_accessor :id
      
      # The version of this response. The identifier for the version of SAML defined in this specification is "2.0".
      attr_accessor :version
      
      # The time instant of issue of the response. The time value must be encoded in UTC.
      attr_accessor :issue_instant
      
      # A URI reference indicating the address to which this response has been sent. This is useful to prevent 
      # malicious forwarding of responses to unintended recipients, a protection that is required by some 
      # protocol bindings. If it is present, the actual recipient MUST check that the URI reference identifies the 
      # location at which the message was received. If it does not, the response MUST be discarded. Some 
      # protocol bindings may require the use of this attribute.
      attr_accessor :destination
      
      # Indicates whether or not (and under what conditions) consent has been obtained from a principal in 
      # the sending of this response.  If no Consent value is provided, the identifier  
      # urn:oasis:names:tc:SAML:2.0:consent:unspecified is in effect.
      attr_accessor :consent
      
      # Identifies the entity that generated the response message.
      attr_accessor :issuer
      
      # An XML Signature that authenticates the responder and provides message integrity.
      attr_accessor :signature
      
      # A code representing the status of the corresponding request.
      attr_accessor :status
      
      # Initialize the Response instance
      def initialize(status)
        @id = UUID.new
        @status = status
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
        raise ValidationError, "Status must be specified" if status.nil?
        raise ValidationError, "Status must be a RSAML::Protocol::Status instance" unless status.is_a?(Status)
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'ID' => id, 'Version' => version, 'IssueInstant' => issue_instant.xmlschema}
        attributes['Destination'] = destination unless destination.nil?
        attributes['Consent'] = consent unless consent.nil?
        xml.tag!('samlp:Response', attributes) {
          xml << issuer.to_xml unless issuer.nil?
          xml << signature.to_xml unless signature.nil?
          # TODO: add extensions support
          xml << status.to_xml unless status.nil?
        }
      end
    end
  end
end