module XmlSig #:nodoc:
    class Transform
    attr_accessor :algorithm
    attr_accessor :xpath

    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Algorightm' => algorithm}
      xml.tag!('ds:Transform', attributes) {
        xml.tag!('ds:XPath', xpath) unless xpath.nil?
      }
    end
  end
  class Base64Transform
    IDENTIFIER = 'http://www.w3.org/2000/09/xmldsig#base64'
    def process(content)
      content # TODO: implement
    end
  end
  class XPathFiltering
    IDENTIFIER = 'http://www.w3.org/TR/1999/REC-xpath-19991116'
    def process(content)
      content # TODO: implement
    end
  end
  class EnvelopedSignatureTransform
    IDENTIFIER = 'http://www.w3.org/2000/09/xmldsig#enveloped-signature'
    def process(content)
      content # TODO: implement
    end
  end
  class XSLTTransform
    IDENTIFIER = 'http://www.w3.org/TR/1999/REC-xslt-19991116'
    def process(content)
      content # TODO: implement
    end
  end
end