module RSAML #:nodoc:
  class ProxyRestriction
    # Specifies the maximum number of indirections that the asserting party permits to exist between this 
    # assertion and an assertion which has ultimately been issued on the basis of it.
    attr_accessor :count
    
    def audiences
      @audiences ||= []
    end
    
    # Construct an XML fragment representing the proxy restriction
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Count'] = count unless count.nil?
      xml.tag!('ProxyRestriction', attributes) {
        audiences.each { |audience| xml << audience.to_xml }
      }
    end
    
    def validate
      raise ValidationError, "Count must be 0 or more if specified" if !count.nil? && count < 0
    end
  end
end