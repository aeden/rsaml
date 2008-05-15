module RSAML
  module Statement
    # The assertion subject was authenticated by a particular means at a particular time.
    class Authentication < Base
      # Specifies the time at which the authentication took place. The time value is encoded in UTC
      attr_accessor :authn_instant
    
      # Specifies the index of a particular session between the principal identified by the subject and the 
      # authenticating authority. In general, any string value MAY be used as a SessionIndex value. 
      # However, when privacy is a consideration, care must be taken to ensure that the SessionIndex 
      # value does not invalidate other privacy mechanisms. Accordingly, the value SHOULD NOT be usable 
      # to correlate activity by a principal across different session participants.
      attr_accessor :session_index
    
      # Specifies a time instant at which the session between the principal identified by the subject and the 
      # SAML authority issuing this statement MUST be considered ended. The time value is encoded in 
      # UTCSpecifies
      attr_accessor :session_not_on_or_after
    
      # Specifies the DNS domain name and IP address for the system from which the assertion subject was 
      # apparently authenticated.
      attr_accessor :subject_locality
    
      attr_accessor :authn_context
    
      def initialize
        @authn_instant = Time.now.utc
      end
    end
  end
end