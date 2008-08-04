module RSAML #:nodoc:
  module Protocol #:nodoc:
    # The ArtifactResolve message is used to request that a SAML protocol message be returned in an 
    # <ArtifactResponse> message by specifying an artifact that represents the SAML protocol message. 
    # The original transmission of the artifact is governed by the specific protocol binding that is 
    # being used; see [SAMLBind] for more information on the use of artifacts in bindings. 
    #
    # The <ArtifactResolve> message SHOULD be signed or otherwise authenticated and integrity 
    # protected by the protocol binding used to deliver the message.
    class ArtifactResolve
      
    end
  end
end