module RSAML #:nodoc:
  class Parser
    # Parse the given SAML message and return a Ruby object structure representing
    # the message. This may include protocol and core classes.
    def parse(xml)
      messages = []
      xml = REXML::Document.new(xml) if xml.is_a?(String)
      
      if attribute_query_elements = xml.get_elements('samlp:AttributeQuery')
        attribute_query_elements.each do |attribute_query_element|
          messages << Protocol::Query::AttributeQuery.from_xml(attribute_query_element)
        end
      end
      
      case messages.length
      when 1: messages.first
      when 0: nil
      else
        messages
      end
    end
  end
end