module RSAML
  class SubjectConfirmationData
    # A time instant before which the subject cannot be confirmed. The time value is encoded in UTC.
    attr_accessor :not_before
    
    # A time instant at which the subject can no longer be confirmed. The time value is encoded in UTC.
    attr_accessor :not_on_or_after
    
    # A URI specifying the entity or location to which an attesting entity can present the assertion. For 
    # example, this attribute might indicate that the assertion must be delivered to a particular network 
    # endpoint in order to prevent an intermediary from redirecting it someplace else. 
    attr_accessor :recipient
    
    # The ID of a SAML protocol message in response to which an attesting entity can present the 
    # assertion. For example, this attribute might be used to correlate the assertion to a SAML request that 
    # resulted in its presentation.
    attr_accessor :in_response_to
    
    # The network address/location from which an attesting entity can present the assertion. For example, 
    # this attribute might be used to bind the assertion to particular client addresses to prevent an attacker 
    # from easily stealing and presenting the assertion from another location.
    attr_accessor :address
    
    # Point for extension attributes
    def attributes
      @attributes = []
    end
    
    # Point for extension elements
    def elements
      @elements = []
    end
  end
end