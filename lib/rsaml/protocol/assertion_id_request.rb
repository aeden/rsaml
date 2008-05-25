module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Request to return assertions with the given ids
    class AssertionIDRequest
      # Specify each assertion to return.
      def assertion_id_refs
        @assertion_id_refs ||= []
      end
      
      # Construct an XML fragment representing the assertion id request
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('samlp:AssertionIDRequest') {
          assertion_id_refs.each { |assertion_id_ref| xml << assertion_id_ref.to_xml }
        }
      end
    end
  end
end