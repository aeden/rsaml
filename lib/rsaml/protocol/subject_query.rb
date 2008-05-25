module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Extension point that allows new SAML queries to be defined that specify a single SAML subject.
    # This class should not be instantiated directly.
    class SubjectQuery
      # The subject
      attr_accessor :subject
      
      # Initialize the subject query
      def initialize(subject)
        @subject = subject
      end
      
      # Validate the subject query structure.
      def validate
        raise ValidationError, "Subject is required" if subject.nil?
      end
    end
  end
end