module RSAML
  module Protocol
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
        {
          :success => SUCCESS,
          :requestor => REQUESTOR,
          :responder => RESPONDER,
          :version_mismatch => VERSION_MISMATCH
        }
      end
      
      def self.second_level_status_codes
        
      end
      
      # The status code value. Value is a URI reference.
      attr_accessor :value
      
      # An optional child status code.
      attr_accessor :status_code
      
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