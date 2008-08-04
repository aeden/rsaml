module RSAML #:nodoc:
  # Namespaces for actions.
  class ActionNamespace
    # A Hash of predefined namespaces from the SAML 2.0 specification. The value for each
    # key/value pair is an ActionNamespace instance with a URI and set of action names.
    def self.namespaces
      @namespaces ||= {
        :rwedc => ActionNamespace.new('urn:oasis:names:tc:SAML:1.0:action:rwedc', [
          'Read','Write','Execute','Delete','Control'
        ]),
        :rwedc_negation => ActionNamespace.new('urn:oasis:names:tc:SAML:1.0:action:rwedc-negation', [
          'Read','Write','Execute','Delete','Control','~Read','~Write','~Execute','~Delete','~Control'
        ]),
        :ghpp => ActionNamespace.new('urn:oasis:names:tc:SAML:1.0:action:ghpp', [
          'GET','HEAD','PUT','POST'
        ]),
        :unix => UnixActionNamespace.new
      }
    end
    
    def self.namespace_for_uri(uri)
      namespaces.values.find { |ns| ns.uri == uri }
    end

    # URI identifying this action namespace
    attr_accessor :uri
    
    # Common sets of actions to perform on resources.
    attr_accessor :action_names
    
    # Initialize the action namespace with the given URI and action names
    def initialize(uri, action_names)
      @uri = uri
      @action_names = action_names
    end
    
    # Return true if the given value is a valid action in the namespace.
    def valid_action?(value)
      action_names.include?(value)
    end
    
    # Return a string representation, specifically the URI for the namespace.
    def to_s
      uri
    end
  end
  
  # Unix Action namespace implementation
  class UnixActionNamespace < ActionNamespace
    # Initialize
    def initialize
      super('urn:oasis:names:tc:SAML:1.0:action:unix', [])
    end
    
    # Return true if the given value is a valid action
    def valid_action?(value)
      # TODO: implement octal check
      false
    end
  end
end