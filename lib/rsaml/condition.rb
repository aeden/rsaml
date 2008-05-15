module RSAML
  class Condition
    # Return true if the condition is valid
    def valid?
      begin
        validate
      rescue ValidationError => e
        return false
      end
      return true
    end
    
    # Raise an error unless the condition is valid
    def validate
      
    end
  end
end