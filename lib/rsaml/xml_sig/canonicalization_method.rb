module RSAML
  module XmlSig
    class CanonicalizationMethod
      attr_accessor :algorithm

      def validate
        raise ValidationError, "Algorithm is required" if algorithm.nil?
      end

      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Algorightm' => algorithm}
        xml.tag!('ds:CanonicalizationMethod', attributes)
      end
    end
    
    # Canonicalization algorithm for XML removing comments
    class XMLC14NWithComments
      def process(content, charset='UTF-8')
        content
      end
    end
    class XMLC14NWithoutComments
      def process(content, charset='UTF-8')
        content
      end
    end
  end
end