module RSAML
  module Statement
    # The assertion subject is associated with the supplied attributes.
    class AttributeStatement < Base
      # Specifies attributes of the assertion subject.
      def attributes
        @attributes ||= []
      end
      
      # Validate the structure of the attribute statement. Raises a validation error if:
      #
      # * Has no attributes specified
      # * Any of the attributes are invalid
      def validate
        raise ValidationError, "At least one attribute must be specified" if @attributes.empty?
        @attributes.each { |attribute| attribute.validate }
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