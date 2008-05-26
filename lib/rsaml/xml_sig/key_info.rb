module RSAML #:nodoc:
  module XmlSig #:nodoc:
    class KeyInfo
      attr_accessor :id
      attr_accessor :key_name
      attr_accessor :key_value
      attr_accessor :retrieval_method
      attr_accessor :key_data

      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('ds:KeyInfo') {
          xml.tag!('ds:KeyName', key_name)
          xml.tag!('ds:KeyValue') {
            xml << key_value.to_xml
          }
        }
      end
    end
    
    class RetrievalMethod
      attr_accessor :uri
      attr_accessor :type
      
      def transforms
        @transforms ||= []
      end
      
      def validate
        raise ValidationError, "URI is required" if uri.nil?
      end
      
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'URI' => uri}
        attributes['Type'] = type unless type.nil?
        xml.tag!('ds:RetrievalMethod', attributes) {
          transforms.each { |transform| xml << transform.to_xml }
        }
      end
    end

    # REQUIRED
    class DSAKeyValue
    end
    # OPTIONAL
    class RSAKeyValue
    end

    class X509Data
    end
    class PGPData
    end
    class SPKIData
    end
    class MgmtData
    end
  end
end