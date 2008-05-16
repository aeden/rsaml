module RSAML #:nodoc:
  # The validator class provides a valid? method that will invoke the validate
  # method on the target object and rescue a ValidationError. If a ValidationError
  # is raised then this method will return false, otherwise it will return true.
  class Validator
    class << self
      attr_accessor :verbose
    end
    
    # Return true if the object is valid. Only objects with a validate method will
    # be checked for validity.
    def self.valid?(o)
      if o.respond_to?(:validate)
        begin
          o.validate
        rescue ValidationError => e
          puts "Validation failed: #{e.message}" if verbose
          return false
        end
      end
      return true
    end
  end
end