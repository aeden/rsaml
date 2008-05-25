module RSAML #:nodoc:
  # A URI reference that identifies an intended audience. The URI reference MAY identify a document 
  # that describes the terms and conditions of audience membership. It MAY also contain the unique 
  # identifier URI from a SAML name identifier that describes a system entity.
  class Audience
    # URI for the audience
    attr_accessor :uri
    
    # Initialize the Audience instance with the given URI
    def initialize(uri)
      @uri = uri
    end
    
    # Construct an XML fragment representing the audience
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:Audience', uri)
    end
  end
end