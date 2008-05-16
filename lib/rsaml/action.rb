module RSAML
  class Action
    
    # Identifiers that MAY be used in the namespace attribute of the Action element to refer to 
    # common sets of actions to perform on resources.
    #
    # Each namespace provides a defined set of actions. Please refer to the SAML 2.0 specification
    # for additional information.
    def self.namespaces
      ActionNamespace.namespaces
    end
    
    # A URI reference representing the namespace in which the name of the specified action is to be 
    # interpreted. If this element is absent, the namespace 
    # urn:oasis:names:tc:SAML:1.0:action:rwedc-negation is in effect.
    attr_accessor :namespace
    
    def namespace
      @namespace ||= Action.namespaces[:rwedc_negation]
    end
  end
end