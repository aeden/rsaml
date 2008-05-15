module RSAML
  # This element is entirely advisory, since both of these fields are quite easily “spoofed,” 
  # but may be useful information in some applications.
  class SubjectLocality
    # The network address of the system from which the principal identified by the subject was 
    # authenticated.
    attr_accessor :address
    
    # The DNS name of the system from which the principal identified by the subject was authenticated.
    attr_accessor :dns_name
  end
end