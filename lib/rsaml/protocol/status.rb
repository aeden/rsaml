module RSAML #:nodoc:
  module Protocol #:nodoc:
    # A SAML status indicator.
    class Status
      # A code representing the status of the activity carried out in response to the corresponding request.
      attr_accessor :status_code
      
      # A message which MAY be returned to an operator.
      attr_accessor :status_message
      
      # Initialize the status with the given status code
      def initialize(status_code)
        @status_code = status_code
      end
      
      # Additional information concerning the status of the request. All objects in the collection must
      # respond to the to_xml method.
      def status_detail
        @status_detail ||= []
      end
      
      # Validate the structure of the Status instance
      def validate
        raise ValidationError, "Status code required" if status_code.nil?
        raise ValidationError, "Status code must be a RSAML::Protocol::StatusCode instance" unless status_code.is_a?(StatusCode)
      end
      
      # Construct an XML fragment representing the request
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('samlp:Status') {
          xml << status_code.to_xml unless status_code.nil?
          xml.tag!('StatusMessage', status_message) unless status_message.nil?
          status_detail.each { |status_detail| xml << status_detail.to_xml }
        }
      end
    end
  end
end