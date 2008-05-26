module RSAML #:nodoc:
  module Protocol #:nodoc:
    class IDPEntry
      attr_accessor :provider_id
      
      # Initialize the IDP entry
      def initialize(provider_id)
        @provider_id = provider_id
      end
      
      # Construct an XML fragment representing the idp list
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'ProviderID' => provider_id}
        xml.tag!('samlp:IDPEntry', attributes)
      end
    end
  end
end