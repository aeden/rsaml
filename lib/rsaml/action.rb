module RSAML
  class Action
    def ns
      'saml'
    end
    
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
    
    # Validate the structure
    def validate
    end
    
    # Construct an XML fragment representing the action
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Namespace'] = namespace unless namespace.nil?
      xml.tag!('saml:Action', attributes)
    end
  end
end