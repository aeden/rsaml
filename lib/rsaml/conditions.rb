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
    
    # Specifies that the assertion is addressed to a particular audience.
    # Audiences are represented as A URI reference that identifies an intended audience.
    def audience_restrictions
      @audience_restrictions ||= []
    end
    
    # Test for validity of the conditions
    def valid?
      valid_time_limits? && valid_elements?
    end
    
    # Return true if the condition allows caching of the assertion
    def cache?
      one_time_use.nil?
    end
    
    protected
    # Check time limit validity.
    def valid_time_limits?
      return false if not_before && Time.now < not_before
      return false if not_on_or_after && Time.now >= not_on_or_after
      return true
    end
    
    # Check condition validity.
    def valid_elements?
      # Rule 1
      if conditions.empty? && audience_restrictions.empty? && proxy_restriction.nil? && one_time_use.nil?
        return true
      end
      
      # Rule 2
      if conditions.find { |c| !c.valid? }
        return false
      end
      
      # Rule 3
      
      # Rule 4
      return true
    end
  end
end