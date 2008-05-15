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
    
    def initialize
      @version = "2.0"
      @id = UUID.new
      @issue_instant = Time.now.utc
    end
    
    # Access the statements in the assertion
    def statements
      @statements ||= []
    end
  end
end