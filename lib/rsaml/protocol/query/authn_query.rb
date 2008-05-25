module RSAML #:nodoc:
  module Protocol #:nodoc:
    module Query #:nodoc:
      # An AuthnQuery is used to make the query "What assertions containing authentication statements 
      # are available for this subject?" A successful response will contain one or more assertions containing 
      # authentication statements.
      class AuthnQuery < SubjectQuery
        # If present, specifies a filter for possible responses. Such a query asks the question "What assertions 
        # containing authentication statements do you have for this subject within the context of the supplied 
        # session information?" The value of this attribute MUST be a string.
        attr_accessor :session_index
      
        # If present, specifies a filter for possible responses. Such a query asks the question "What assertions 
        # containing authentication statements do you have for this subject that satisfy the authentication 
        # context requirements in this element?" The value of this attribute MUST be a RequestedAuthnContext
        # instance.
        attr_accessor :requested_authn_context
      
        # Construct an XML fragment representing the authn query
        def to_xml(xml=Builder::XmlMarkup.new)
          attributes = {}
          attributes['SessionIndex'] = session_index unless session_index.nil?
          xml.tag!('samlp:AuthnQuery', attributes) {
            xml << subject.to_xml unless subject.nil?
          }
        end
      end
    end
  end
end