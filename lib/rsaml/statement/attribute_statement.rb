module RSAML
  module Statement
    # The assertion subject is associated with the supplied attributes.
    class AttributeStatement < Base
      # Specifies attributes of the assertion subject.
      def attributes
        @attributes ||= []
      end
      
      # Construct an XML fragment representing the authentication statement
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('AttributeStatement') {
          attributes.each { |attribute| xml << attribute.to_xml }
        }
      end
    end
  end
end