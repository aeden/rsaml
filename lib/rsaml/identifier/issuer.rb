module RSAML
  module Identifier
    # provides information about the issuer of a SAML assertion or protocol message. T
    # Requires the use of a string to carry the issuer's name  
    class Issuer < Name
      # If no Format value is provided with this element, then the value
      # urn:oasis:names:tc:SAML:2.0:nameid-format:entity is in effect
      def format
        @format ||= Name.formats(:entity)
      end
    end
  end
end