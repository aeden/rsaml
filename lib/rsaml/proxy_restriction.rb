module RSAML #:nodoc:
  class ProxyRestriction
    # Specifies the maximum number of indirections that the asserting party permits to exist between this 
    # assertion and an assertion which has ultimately been issued on the basis of it.
    attr_accessor :count
    
    def audiences
      @audiences ||= []
    end
  end
end