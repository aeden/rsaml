module RSAML #:nodoc:
  module Statement #:nodoc:
    # A request to allow the assertion subject to access the specified resource 
    # has been granted or denied.
    class AuthorizationDecisionStatement < Base
      # defines the possible values to be reported as the status of an authorization decision statement. 
      # 
      # Possible values are:
      # * <tt>Permit</tt>: The specified action is permitted. 
      # * <tt>Deny</tt>: The specified action is denied. 
      # * <tt>Indeterminate</tt> The SAML authority cannot determine whether the specified action 
      #   is permitted or denied.
      def self.decision_types
        %w(Permit Deny Indeterminate)
      end
      
      # A URI reference identifying the resource to which access authorization is sought. 
      # This attribute MAY have the value of the empty URI reference (""), and the meaning 
      # is defined to be "the start of the current document"
      attr_accessor :resource
      
      # The decision rendered by the SAML authority with respect to the specified resource.
      attr_accessor :decision
      
      # The set of actions authorized to be performed on the specified resource.
      def actions
        @actions ||= []
      end
      
      # A set of assertions that the SAML authority relied on in making the decision.
      def evidence
        @evidence ||= []
      end
      
      # Construct an XML fragment representing the authorization decision statement
      def to_xml(xml=Builder::XmlMarkup.new)
        xml.tag!('AuthzStatement')
      end
    end
  end
end