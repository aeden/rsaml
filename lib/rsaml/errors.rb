module RSAML #:nodoc:
  # An error that is raised when a validation error occurs. Note that validity in the case
  # of this library is for validity of the structure of the model according to the rules
  # of the SAML 2.0 specification.
  class ValidationError < StandardError
  end
  # An error that is raised when an assertion fails.
  class AssertionError < StandardError
  end
  # An error that is raised when a confirmation fails.
  class ConfirmationError < StandardError
  end
end