module RSAML #:nodoc:
  # specifies additional data that allows the subject to be confirmed or constrains the circumstances under 
  # which the act of subject confirmation can take place. Subject confirmation takes place when a relying 
  # party seeks to verify the relationship between an entity presenting the assertion (that is, the attesting 
  # entity) and the subject of the assertion's claims.
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
    
    # Confirm the subject confirmation data
    def confirm
      raise ConfirmationError, "Subject confirmation failed: not before" if not_before && Time.now < not_before
      raise ConfirmationError, "Subject confirmation failed: not on or after" if not_on_or_after && Time.now >= not_on_or_after
      # TODO implement tests for remaining elements such as recipient, in_response_to and address
    end

    def to_xml(xml=Builder::XmlMarkup.new)
     attributes = {}
     attributes['Recipient'] = recipient unless recipient.nil?
     attributes['NotOnOrAfter'] = not_on_or_after unless not_on_or_after.nil?
     attributes['NotBefore'] = not_before unless not_before.nil?
     attributes['InResponseTo'] = in_response_to unless in_response_to.nil?
     attributes[ 'Address'] = address unless address.nil?
     xml.tag!('saml:SubjectConfirmationData', attributes)
    end
  end
end
