require 'iconv'

module XmlSig #:nodoc:
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
  
  class XMLC14NBase
    # Convert the content from the given charset to UTF-8.
    def convert_to_utf8(content, from)
      Iconv.iconv('UTF-8', from, content).join
    end
    def convert_linebreaks(content)
      content.gsub(/\r\n/, "\n").gsub(/\r/, "\n")
    end
    def normalize_attribute_values(content)
      
    end
  end
  
  # Canonicalization algorithm for XML removing comments
  class XMLC14NWithComments < XMLC14NBase
    def process(content, charset='UTF-8')
      content = convert_to_utf8(content) unless charset == 'UTF-8'
      content
    end
  end
  class XMLC14NWithoutComments < XMLC14NBase
    def process(content, charset='UTF-8')
      content = convert_to_utf8(content) unless charset == 'UTF-8'
      doc = REXML::Document.new(content)
    end
  end
end