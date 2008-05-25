module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Specifies the authentication context requirements of authentication statements returned in 
    # response to a request or query.
    class RequestedAuthnContext
      # List of available comparison values
      def self.comparisons
        @comparisons ||= ['exact','minimum','maximum','better']
      end
      
      # Authentication context references, either AuthnContextDeclRef or AuthnContextClassRef.
      def authn_context_refs
        @authn_context_refs ||= []
      end
      
      # Specifies the comparison method used to evaluate the requested context classes or statements, one 
      # of "exact", "minimum", "maximum", or "better". The default is "exact"
      def comparison
        @comparison ||= 'exact'
      end
      
      # Validate the structure of the requested authn context
      def validate
        raise ValidationError, "Unknown comparison type: #{comparison}" unless RequestedAuthContext.comparisons.include?(comparison)
      end
      
      # Construct an XML fragment representing the requested authn context
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {'Comparison' => comparison}
        xml.tag!('samlp:RequestedAuthnContext')
      end
    end
  end
end