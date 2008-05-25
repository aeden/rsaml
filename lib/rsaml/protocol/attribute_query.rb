module RSAML #:nodoc:
  module Protocol #:nodoc:
    # used to make the query "Return the requested attributes for this subject." A successful response 
    # will be in the form of assertions containing attribute statements, to the extent allowed by policy.
    class AttributeQuery < SubjectQuery
      # Each attribute element specifies an attribute whose value(s) are to be returned. If no 
      # attributes are specified, it indicates that all attributes allowed by policy are requested. 
      # If a given attribute element contains one or more AttributeValue elements, then if that attribute 
      # is returned in the response, it MUST NOT contain any values that are not equal to the values 
      # specified in the query. In the absence of equality rules specified by particular profiles or 
      # attributes, equality is defined as an identical XML representation of the value. Each value in 
      # the array MUST be an Attribute instance.
      def attributes
        @attributes ||= []
      end
      
      # Validate the structure of the attribute query.
      def validate
        matched = {}
        duplicated_attributes = []
        attributes.each do |attribute|
          if matched.has_key?(attribute.name) && matched[attribute.name] == attribute.name_format
            duplicated_attributes << attribute.name unless duplicated_attributes.include?(attribute.name)
          else
            matched[attribute.name] = attribute.name_format
          end
        end
        if !duplicated_attributes.empty?
          raise ValidationError, "An attribute with the same name and name format may only be specified once. The following attributes were specified multiple times: #{duplicated_attributes.join(',')}"
        end
      end
      
      # Construct an XML fragment representing the attribute query
      def to_xml(xml=Builder::XmlMarkup.new)
        xml_attributes = {}
        xml.tag!('samlp:AttributeQuery', xml_attributes) {
          xml << subject.to_xml unless subject.nil?
        }
      end
    end
  end
end