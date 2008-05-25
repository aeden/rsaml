module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML response
    class Response < Message
      # A reference to the identifier of the request to which the response corresponds, if any. If the response 
      # is not generated in response to a request, or if the ID attribute value of a request cannot be 
      # determined (for example, the request is malformed), then this attribute MUST NOT be present. 
      # Otherwise, it MUST be present and its value MUST match the value of the corresponding request's 
      # ID attribute.
      attr_accessor :in_response_to
      
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
        attributes['InResponseTo'] = in_response_to unless in_response_to.nil?
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