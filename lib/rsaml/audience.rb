module RSAML
  class Audience
    # URI for the audience
    attr_accessor :uri
    
    def initialize(uri)
      @uri = uri
    end
    
    # Construct an XML fragment representing the audience
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('Audience', uri)
    end
  end
end