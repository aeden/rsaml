module RSAML #:nodoc:
  module Protocol #:nodoc:
    # Module containing SAML query classes.
    module Query
    end
  end
end

require 'rsaml/protocol/query/subject_query'
require 'rsaml/protocol/query/authn_query'
require 'rsaml/protocol/query/attribute_query'
require 'rsaml/protocol/query/authz_decision_query'