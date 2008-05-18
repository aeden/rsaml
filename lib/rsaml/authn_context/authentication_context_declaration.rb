module RSAML #:nodoc:
  module AuthnContext #:nodoc:
    # A particular assertion on an identity provider's part with respect to the authentication
    # context associated with an authentication assertion.
    class AuthenticationContextDeclaration
      # Authentication method, a required attribute
      attr_accessor :authn_method
      
      # Optional ID for the authentication context declaration
      attr_accessor :id
      
      def initialize(authn_method)
        @authn_method = authn_method
      end
      
      def identification
        @identification ||= []
      end
      
      def technical_protection
        @technical_protection ||= []
      end
      
      def operational_protection
        @operational_protection ||= []
      end
      
      def governing_agreements
        @governing_agreements ||= []
      end
      
      def extensions
        @extensions ||= []
      end
      
      # Construct an XML fragment representing the assertion
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('AuthContextDecl')
      end
    end
  end
end