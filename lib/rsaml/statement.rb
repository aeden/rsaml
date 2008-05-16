module RSAML #:nodoc
  # Module that contain SAML statements.
  module Statement
  end
end

require 'rsaml/statement/base'
require 'rsaml/statement/authentication_statement'
require 'rsaml/statement/attribute_statement'
require 'rsaml/statement/authorization_decision_statement'