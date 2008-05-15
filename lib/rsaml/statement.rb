module RSAML
  class Statement
    # An xsi:type attribute used to indicate the actual statement type.
    attr_accessor :type
  end
  
  # The assertion subject was authenticated by a particular means at a particular time.
  class Authentication < Statement
    # Specifies the time at which the authentication took place. The time value is encoded in UTC
    attr_accessor :authn_instant
    
    # Specifies the index of a particular session between the principal identified by the subject and the 
    # authenticating authority.
    attr_accessor :session_index
    
    def initialize
      @authn_instant = Time.now.utc
    end
  end
  
  # The assertion subject is associated with the supplied attributes.
  class Attribute < Statement
  
  end
  
  # A request to allow the assertion subject to access the specified resource 
  # has been granted or denied.
  class AuthorizationDecision < Statement
    
  end
end