module RSAML #:nodoc:
  # Specifies limitations that the asserting party imposes on relying parties that in turn wish to act as asserting 
  # parties and issue subsequent assertions of their own on the basis of the information contained in the 
  # original assertion. A relying party acting as an asserting party MUST NOT issue an assertion that itself 
  # violates the restrictions specified in this condition on the basis of an assertion containing such a condition.
  class ProxyRestriction
    # Specifies the maximum number of indirections that the asserting party permits to exist between this 
    # assertion and an assertion which has ultimately been issued on the basis of it.
    attr_accessor :count
    
    def audiences
      @audiences ||= []
    end
    
    # Validate the structure
    def validate
      raise ValidationError, "Count must be 0 or more if specified" if !count.nil? && count < 0
    end
    
    # Construct an XML fragment representing the proxy restriction
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Count'] = count unless count.nil?
      xml.tag!('saml:ProxyRestriction', attributes) {
        audiences.each { |audience| xml << audience.to_xml }
      }
    end
    
  end
end