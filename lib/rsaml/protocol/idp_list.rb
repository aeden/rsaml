module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Specifies the identity providers trusted by the requester to authenticate the presenter.
    class IDPList
      # Initialize the IDP list
      def initialize(*idp_entries)
        @idp_entries = idp_entries
      end
      
      # Information about identity providers.
      def idp_entries
        @idp_entries ||= []
      end
      
      # Validate the IDPList structure.
      def validate
        raise ValidationError, "At least one IDP entry is required" if idp_entries.empty?
      end
      
      # Construct an XML fragment representing the idp list
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('samlp:IDPList') {
          idp_entries.each { |idp_entry| xml << idp_entry.to_xml }
        }
      end
    end
  end
end