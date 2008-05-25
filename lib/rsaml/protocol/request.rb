module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML request
    class Request < Message
      # Generate a Response instance with the given status code. The response's in_response_to attribute
      # will be set to the ID of the request.
      def respond(status)
        response = Response.new(status)
        response.in_response_to = id
        response
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'ID' => id, 'Version' => version, 'IssueInstant' => issue_instant.xmlschema}
        attributes['Destination'] = destination unless destination.nil?
        attributes['Consent'] = consent unless consent.nil?
        attributes = add_xmlns(attributes)
        xml.tag!('samlp:Request', attributes) {
          xml << issuer.to_xml unless issuer.nil?
          xml << signature.to_xml unless signature.nil?
          # TODO: add extensions support
        }
      end
    end
  end
end