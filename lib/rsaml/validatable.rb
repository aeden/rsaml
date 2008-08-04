module RSAML
  # Module that can be mixed in to any class to provide a :valid? method. This method
  # will look for a :validate method and invoke it, catching any ValidationError exceptions
  # and return either true if the SAML object is structurally valid or false if it isn't.
  module Validatable
    attr_accessor :verbose
    # Return true if the object is valid. Only objects with a validate method will
    # be checked for validity.
    def valid?
      if respond_to?(:validate)
        begin
          validate
        rescue ValidationError => e
          puts "Validation failed: #{e.message}" if verbose
          return false
        end
      end
      return true
    end
  end
end