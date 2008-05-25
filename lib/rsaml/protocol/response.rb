module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML response
    class Response < Message
      
      # A code representing the status of the corresponding request.
      attr_accessor :status
      
      # Initialize the Response instance
      def initialize(status)
        super()
        @status = status
      end
      
      # Validate the request structure
      def validate
        super
        raise ValidationError, "Status must be specified" if status.nil?
        raise ValidationError, "Status must be a RSAML::Protocol::Status instance" unless status.is_a?(Status)
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'ID' => id, 'Version' => version, 'IssueInstant' => issue_instant.xmlschema}
        attributes['Destination'] = destination unless destination.nil?
        attributes['Consent'] = consent unless consent.nil?
        attributes = add_xmlns(attributes)
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