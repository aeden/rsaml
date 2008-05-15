module RSAML
  class Statement
  end
  
  # The assertion subject was authenticated by a particular means at a particular time.
  class Authentication < Statement
    
  end
  
  # The assertion subject is associated with the supplied attributes.
  class Attribute < Statement
  
  end
  
  # A request to allow the assertion subject to access the specified resource 
  # has been granted or denied.
  class AuthorizationDecision < Statement
    
  end
end