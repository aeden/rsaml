module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML request
    class Request
      # An identifier for the request. It is of type xs:ID and MUST follow the requirements specified in Section 
      # 1.3.4 of the SAML 2.0 specification for identifier uniqueness. The values of the ID attribute in a 
      # request and the InResponseTo attribute in the corresponding response MUST match.
      attr_accessor :id
      
      # The version of this request. The identifier for the version of SAML defined in this specification is "2.0".
      attr_accessor :version
      
      # The time instant of issue of the request. The time value must be encoded in UTC.
      attr_accessor :issue_instant
      
      # A URI reference indicating the address to which this request has been sent. This is useful to prevent 
      # malicious forwarding of requests to unintended recipients, a protection that is required by some 
      # protocol bindings. If it is present, the actual recipient MUST check that the URI reference identifies the 
      # location at which the message was received. If it does not, the request MUST be discarded. Some 
      # protocol bindings may require the use of this attribute.
      attr_accessor :destination
      
      # Indicates whether or not (and under what conditions) consent has been obtained from a principal in 
      # the sending of this request.
      attr_accessor :consent
      
      # Initialize the Request instance
      def initialize(id)
        @id = id
        @version = "2.0"
        @issue_instant = Time.now.utc
      end
      
      # Validate the request structure
      def validate
        raise ValidationError, "ID is required" if id.nil?
        raise ValidationError, "Version is required" if version.nil?
        raise ValidationError, "Issue instant is required" if issue_instant.nil?
        raise ValidationError, "Issue instant must be UTC" unless issue_instant.utc?
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'ID' => id, 'Version' => version, 'IssueInstant' => issue_instant.xmlschema}
        attributes['Destination'] = destination unless destination.nil?
        attributes['Consent'] = consent unless consent.nil?
        xml.tag!('samlp:Request', attributes)
      end
    end
  end
end