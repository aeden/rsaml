module RSAML #:nodoc:
  # Constraints on the acceptable use of SAML assertions.
  class Conditions
    # Specifies the earliest time instant at which the assertion is valid. The time value is encoded in UTC.
    attr_accessor :not_before
    
    # Specifies the time instant at which the assertion has expired. The time value is encoded in UTC.
    attr_accessor :not_on_or_after
    
    # Specifies that the assertion SHOULD be used immediately and MUST NOT be retained for future 
    # use.
    attr_accessor :one_time_use
    
    # Specifies limitations that the asserting party imposes on relying parties that wish to subsequently act 
    # as asserting parties themselves and issue assertions of their own on the basis of the information 
    # contained in the original assertion.
    attr_accessor :proxy_restriction
    
    # The conditions
    def conditions
      @conditions ||= []
    end
    
    # Alias to access the embedded conditions array.
    def []
      conditions
    end
    
    # Append a condition to the conditions
    def <<(condition)
      conditions << condition
    end
    
    # The number of conditions
    def length
      conditions.length
    end
    
    # Return true if the conditions collection is empty
    def empty?
      conditions.length == 0 && audience_restrictions.empty?
    end
    
    # Specifies that the assertion is addressed to a particular audience.
    # Audiences are represented as A URI reference that identifies an intended audience.
    # A URI may reference a document that describes the terms of service for audience
    # membership.
    def audience_restrictions
      @audience_restrictions ||= []
    end
    
    # Assert the conditions
    def assert
      assert_time_limits
      assert_elements
    end
    
    # Validate the structure of the conditions model
    def validate
      if not_before && not_on_or_after && not_before >= not_on_or_after
        raise ValidationError, "NotBefore after NotOnOrAfter"
      end
    end
    
    # Return true if the condition allows caching of the assertion
    def cache?
      one_time_use.nil?
    end
    
    # Construct an XML fragment representing the conditions collection
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['NotBefore'] = not_before.xmlschema unless not_before.nil?
      attributes['NotOnOrAfter'] = not_on_or_after.xmlschema unless not_on_or_after.nil?
      xml.tag!('saml:Conditions', attributes) {
        conditions.each { |condition| xml << condition.to_xml }
        audience_restrictions.each do |audience|
          xml.tag!('saml:AudienceRestriction') { xml << audience.to_xml }
        end
        xml.tag!('OneTimeUse') if one_time_use
        xml << proxy_restriction.to_xml unless proxy_restriction.nil?
      }
    end
    
    protected
    # Check the the current time falls within the allowed time constraints
    def assert_time_limits
      raise AssertionError, "Condition failed: not before" if not_before && Time.now < not_before
      raise AssertionError, "Condition failed: not on or after" if not_on_or_after && Time.now >= not_on_or_after
    end
    
    # Assert that the conditions evaluate to true
    def assert_elements
      # Rule 1
      if conditions.empty? && audience_restrictions.empty? && proxy_restriction.nil? && one_time_use.nil?
        return
      end
      
      # Rule 2
      conditions.all { |c| c.assert }
      
      # Rule 3
      
      # Rule 4
    end
  end
end
