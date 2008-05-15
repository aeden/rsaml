module RSAML
  # An assertion is a package of information that supplies zero or more statements made by a SAML 
  # authority.
  class Assertion
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
    #
    # conditions should contain a single Conditions object
    attr_accessor :conditions
    
    # Construct a new assertion from the given issuer
    def initialize(issuer)
      @issuer = issuer
      @version = "2.0"
      @id = UUID.new
      @issue_instant = Time.now.utc
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
    
    # Validate the assertion
    def valid?
      return false if statements.length == 0 && subject.nil?
      return false if signature && !signature.valid?
      if conditions
        assertion_cache << self unless conditions.cache?
        return false if !conditions.valid?
      end
      return true
    end
    
    protected
    def assertion_cache
      @assertion_cache ||= []
    end
  end
end