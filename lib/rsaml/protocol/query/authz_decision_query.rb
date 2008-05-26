module RSAML #:nodoc:
  module Protocol #:nodoc:
    module Query #:nodoc:
      # Used to make the query "Should these actions on this resource be allowed for this subject, 
      # given this evidence?" A successful response will be in the form of assertions containing 
      # authorization decision statements.
      class AuthzDecisionQuery < SubjectQuery
        # A URI reference indicating the resource for which authorization is requested.
        attr_accessor :resource
        
        # The actions for which authorization is requested.
        def actions
          @actions ||= []
        end
        
        # A set of assertions that the SAML authority MAY rely on in making its authorization decision.
        attr_accessor :evidence
        
        # Validate the query structure.
        def validate
          raise ValidationError, "Resource is required" if resource.nil?
          raise ValidationError, "At least one action is required" if actions.empty?
          actions.each { |action| action.validate }
        end
        
        # Construct an XML fragment representing the authorization decision query
        def to_xml(xml=Builder::XmlMarkup.new)
          attributes = {'Resource' => resource}
          xml.tag!('samlp:AuthzDecisionQuery', attributes) {
            xml << subject.to_xml unless subject.nil?
            actions.each { |action| xml << action.to_xml }
            xml << evidence.to_xml unless evidence.nil?
          }
        end
      end
    end
  end
end