module RSAML #:nodoc:
  # Specifies an action on the specified resource for which permission is sought. Its value provides the 
  # label for an action sought to be performed on the specified resource.
  class Action
    include Validatable
    
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
    
    # The action value
    attr_accessor :value
    
    # Initialize the action with the given value.
    def initialize(value)
      @value = value
    end
    
    # The action namespace.
    def namespace
      @namespace ||= Action.namespaces[:rwedc_negation]
    end
    
    # Validate the structure
    def validate
      raise ValidationError, "Action value must be specified" if value.nil?
      raise ValidationError, "Action value not in given namespace" unless namespace.valid_action?(value)
    end
    
    # Construct an XML fragment representing the action.
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {}
      attributes['Namespace'] = namespace unless namespace.nil?
      xml.tag!('saml:Action', attributes, value)
    end
    
    # Construct an Action instance from the given XML Element or fragment.
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)
      action = Action.new(element.text)
      if (namespace_attribute = element.attribute('Namespace'))
        action.namespace = ActionNamespace.namespace_for_uri(namespace_attribute.value)
      end
      action
    end
  end
end