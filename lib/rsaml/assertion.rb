module RSAML #:nodoc:
  # Reference to an assertion via URI
  class AssertionURIRef
    include Validatable
    
    # The URI reference
    attr_accessor :uri
    
    # Initialize the AssertionURIRef with the given URI
    def initialize(uri)
      @uri = uri
    end
    
    # Validate that the AssertionURIRef is structurally valid
    def validate
      raise ValidationError, "A URI is required" if uri.nil?
    end
    
    # Construct an XML fragment representing the assertion uri ref
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:AssertionURIRef', uri)
    end
    
    # Construct an Action instance from the given XML Element or fragment.
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)
      AssertionURIRef.new(element.text)
    end
  end
  
  # Reference to an assertion via ID
  class AssertionIDRef
    include Validatable
    
    # The ID reference
    attr_accessor :id
    
    # Initialize the AssertionIDRef with the given assertion ID
    def initialize(id)
      @id = id
    end
    
    # Validate that the AssertionIDRef is structurally valid
    def validate
      raise ValidationError, "An id is required" if id.nil?
    end
    
    # Construct an XML fragment representing the assertion ID ref
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:AssertionIDRef', id)
    end
    
    # Construct an Action instance from the given XML Element or fragment.
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)
      AssertionIDRef.new(element.text)
    end
  end
  
  # An encrypted assertion
  class EncryptedAssertion < Encrypted
    # Construct an XML fragment representing the encrypted assertion
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:EncryptedAssertion') {
        xml.tag!('xenc:EncryptedData', encrypted_data)
        encrypted_keys.each { |key| xml << encrypted_key.to_xml }
      }
    end
  end
  
  # An assertion is a package of information that supplies zero or more statements made by a SAML 
  # authority.
  class Assertion
    include Validatable
    
    # SAML assertions are usually made about a subject, however the subject is optional
    attr_accessor :subject
    
    # The version of this assertion.
    attr_accessor :version
    
    # The identifier for this assertion.
    attr_accessor :id
    
    # The time instant of issue in UTC
    attr_accessor :issue_instant
    
    # The SAML authority that is making the claim(s) in the assertion. The issuer SHOULD be unambiguous 
    # to the intended relying parties.  
    attr_accessor :issuer
    
    # A signature that protects the integrity of and authenticates the issuer of the assertion.
    attr_accessor :signature
    
    # The subject of the statement(s) in the assertion.
    attr_accessor :subject
    
    # Conditions that MUST be evaluated when assessing the validity of and/or when using the assertion. 
    # Note: conditions should contain a single Conditions instance, not an array of Condition instances.
    attr_accessor :conditions
    
    # Construct a new assertion from the given issuer
    def initialize(issuer)
      @issuer = issuer
      @version = "2.0"
      @id = UUID.new.generate
      @issue_instant = Time.now.utc
    end
    
    # Conditions collection
    def conditions
      @conditions ||= Conditions.new
    end
    
    # Assertion statements
    def statements
      @statements ||= []
    end
    
    # Additional information related to the assertion that assists processing in certain situations but which 
    # MAY be ignored by applications that do not understand the advice or do not wish to make use of it.
    def advice
      @advice ||= []
    end
        
    # Assert the assertion.
    def assert
      # rule: if there is a signature it must be asserted
      signature.assert if signature
      
      # rule: if there are conditions then they must be asserted
      if conditions
        # rule: an assertion cache should be kept if conditions allow it
        assertion_cache << self unless conditions.cache?
        conditions.assert
      end
    end
    
    # Validate the assertion. This validates the structural integrity of the assertion, not the
    # validity of the assertion itself. To "assert" the assertion use the assert method.
    def validate
      # rule: if there are no statements there must be a subject
      if statements.length == 0 && subject.nil?
        raise ValidationError, "An assertion with no statements must have a subject"
      end
      
      # rule: if there is an authentication then there must be a subject
      statements.each do |statement|           
        if statement_classes.include?(statement.class)
          if subject.nil?
            raise ValidationError, "An assertion with an #{statement.class.name} must have a subject"
          else
            break
          end
        end
      end
    end
    
    # Construct an XML fragment representing the assertion
    def to_xml(xml=Builder::XmlMarkup.new)
      attributes = {'Version' => version, 'ID' => id, 'IssueInstant' => issue_instant.xmlschema}
      xml.tag!('saml:Assertion', attributes) {
        xml << issuer.to_xml
        xml << signature.to_xml unless signature.nil?
        xml << subject.to_xml unless subject.nil?
        xml << conditions.to_xml unless conditions.nil? || conditions.empty?
        advice.each { |a| xml << a.to_xml }
        statements.each { |s| xml << s.to_xml }
      }
    end
    
    # Construct an Action instance from the given XML Element or fragment.
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)
      issuer = Identifier::Issuer.from_xml(element.get_elements('saml:Issuer').first)
      assertion = Assertion.new(issuer)
      if (subject = element.get_elements('saml:Subject').first)
        assertion.subject = Subject.from_xml(subject)
      end
      assertion
    end
    
    protected
    def assertion_cache
      @assertion_cache ||= []
    end
    
    def statement_classes
      [AuthenticationStatement, AttributeStatement, AuthorizationDecisionStatement]
    end
  end
end