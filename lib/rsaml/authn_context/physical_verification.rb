module RSAML #:nodoc:
  module AuthnContext #:nodoc:
    # This element indicates that identification has been performed in a physical 
    # face-to-face meeting with the principal and not in an online manner.
    class PhysicalVerification
      # Hash of available credential levels
      def self.credential_levels
        {
          :primary => 'primary',
          :secondary => 'secondary'
        }
      end
      
      attr_accessor :credential_level
      
      # Create an XML representation
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['credentialLevel'] = credential_level unless credential_level.nil?
        xml.tag!('PhysicalVerification', attributes)
      end
    end
  end
end