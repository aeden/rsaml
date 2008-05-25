module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A code or a set of nested codes representing the status of the corresponding request.
    # 
    # More information on available status codes may be found in Section 3.2.2.2 of the SAML 2.0 Core
    # specification.
    class StatusCode
      # Initialize the status code with the given value
      def initialize(value)
        @value = value
      end
      
      # Constant respresenting the Success status
      SUCCESS = StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:Success')
      
      # Constant representing the Requestor status
      REQUESTOR = StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:Requestor')
      
      # Constant representing the Responder status
      RESPONDER = StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:Responder')
      
      # Constant representing the VersionMismatch status
      VERSION_MISMATCH = StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:VersionMismatch')
      
      # Hash of symbol/StatusCode pairs representing top-level status codes.
      def self.top_level_status_codes
        @top_level_status_codes ||= {
          :success => SUCCESS,
          :requestor => REQUESTOR,
          :responder => RESPONDER,
          :version_mismatch => VERSION_MISMATCH
        }
      end
      
      # Hash of symbol/StatusCode pairs representing second-level status codes.
      def self.second_level_status_codes
        @second_level_status_codes ||= {
          :authn_failed => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:AuthnFailed'),
          :invalid_attr_name_or_value => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:InvalidAttrNameOrValue'),
          :invalid_name_id_policy => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:InvalidNameIDPolicy'),
          :no_authn_context => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:NoAuthnContext'),
          :no_available_idp => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:NoAvailableIDP'),
          :no_passive => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:NoPassive'),
          :no_supported_idp => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:NoSupportedIDP'),
          :partial_logout => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:PartialLogout'),
          :proxy_count_exceeded => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:ProxyCountExceeded'),
          :request_denied => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:RequestDenied'),
          :request_unsupported => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:RequestUnsupported'),
          :request_version_deprecated => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:RequestVersionDeprecated'),
          :request_version_too_high => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooHigh'),
          :request_version_too_low => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:RequestVersionTooLow'),
          :resource_not_recognized => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:ResourceNotRecognized'),
          :too_many_responses => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:TooManyResponse'),
          :unknown_attr_profile => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:UnknownAttrProfile'),
          :unknown_principal => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:UnknownPrincipal'),
          :unsupported_binding => StatusCode.new('urn:oasis:names:tc:SAML:2.0:status:UnsupportedBinding'),
        }
      end
      
      # The status code value. Value is a URI reference.
      attr_accessor :value
      
      # An optional child status code.
      attr_accessor :status_code
      
      def validate
        raise ValidationError, "Value is required" if value.nil?
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Value' => value}
        xml.tag!('samlp:StatusCode', attributes) {
          xml << status_code.to_xml unless status_code.nil?
        }
      end
      
      # Return the value of the status code as a string.
      def to_s
        value
      end
    end
  end
end