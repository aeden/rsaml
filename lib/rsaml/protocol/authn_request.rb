module RSAML #:nodoc:
  module Protocol #:nodoc:
    # To request that an identity provider issue an assertion with an authentication statement, a presenter 
    # authenticates to that identity provider (or relies on an existing security context) and sends it an 
    # <AuthnRequest> message that describes the properties that the resulting assertion needs to have to 
    # satisfy its purpose. Among these properties may be information that relates to the content of the assertion 
    # and/or information that relates to how the resulting <Response> message should be delivered to the 
    # requester. The process of authentication of the presenter may take place before, during, or after the initial 
    # delivery of the <AuthnRequest> message. 
    #
    # The requester might not be the same as the presenter of the request if, for example, the requester is a 
    # relying party that intends to use the resulting assertion to authenticate or authorize the requested subject 
    # so that the relying party can decide whether to provide a service.
    class AuthnRequest < Request
      # Specifies the requested subject of the resulting assertion(s).
      attr_accessor :subject
      
      # Specifies constraints on the name identifier to be used to represent the requested subject. If omitted, 
      # then any type of identifier supported by the identity provider for the requested subject can be used, 
      # constrained by any relevant deployment-specific policies, with respect to privacy, for example.
      attr_accessor :name_id_policy
      
      # Specifies the SAML conditions the requester expects to limit the validity and/or use of the resulting 
      # assertion(s). The responder MAY modify or supplement this set as it deems necessary. The 
      # information in this element is used as input to the process of constructing the assertion, rather than as 
      # conditions on the use of the request itself.
      attr_accessor :conditions
      
      # Specifies the requirements, if any, that the requester places on the authentication context that applies 
      # to the responding provider's authentication of the presenter.  
      attr_accessor :requested_authn_context
      
      # Specifies a set of identity providers trusted by the requester to authenticate the presenter, as well as 
      # limitations and context related to proxying of the <Au message to subsequent identity providers by the 
      # responder.
      attr_accessor :scoping
      
      # Validate the authentication request.
      def validate
        raise ValidationError, "Conditions must be of type Conditions" if conditions && !conditions.is_a?(Conditions)
      end
      
      # Construct an XML fragment representing the authentication request
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('samlp:AuthnRequest') {
          xml << subject.to_xml unless subject.nil?
          xml << name_id_policy.to_xml unless name_id_policy.nil?
          xml << conditions.to_xml unless conditions.nil?
          xml << requested_authn_context unless requested_authn_context.nil?
          xml << scoping.to_xml unless scoping.nil?
        }
      end
    end
  end
end