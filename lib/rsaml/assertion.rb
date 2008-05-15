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
    
    def subject=(value)
      case value
      when String: 
        @subject = Subject.new(Name.new(value))
      else
        @subject = value
      end
    end
    
    # Validate the assertion. If the assertion is valid then this method will return true.
    def valid?
      begin
        validate
      rescue RSAML::ValidationError => e
        return false
      end
      return true
    end
        
    # Validate the assertion. If the assertion is invalid then this method will raise a
    # ValidationError.
    def validate
      # rule: if there are no statements there must be a subject
      if statements.length == 0 && subject.nil?
        raise ValidationError, "An assertion with no statements must have a subject"
      end

      # rule: if there is a signature it must be valid
      if signature && !signature.valid?
        raise ValidationError, "An assertion signature must be valid"
      end
      
      # rule: if there are conditions then they must be valid
      if conditions
        # rule: an assertion cache should be kept if conditions allow it
        assertion_cache << self unless conditions.cache?
        if !conditions.valid?
          raise ValidationError, "Conditions are not valid"
        end
      end
      
      # rule: if there is an authentication then there must be a subject
      statements.each do |statement|           
        if statement.is_a?(Authentication)     
          if subject.nil?
            raise ValidationError, "An assertion with an Authentication statement must have a subject"
          else
            break
          end
        end
        if statement.is_a?(Attribute)
          if subject.nil?
            raise ValidationError, "An assertion with an Attribute statement must have a subject"
          else
            break
          end
        end
      end
      
      return true
    end
    
    protected
    def assertion_cache
      @assertion_cache ||= []
    end
  end
end