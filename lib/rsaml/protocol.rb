module RSAML #:nodoc:
  # The protocol module contains request and response classes for the SAML protocol implementation
  module Protocol 
  end
end

require 'rsaml/protocol/message'
require 'rsaml/protocol/status_code'
require 'rsaml/protocol/status'
require 'rsaml/protocol/request'
require 'rsaml/protocol/response'

require 'rsaml/protocol/name_id_policy'
require 'rsaml/protocol/scoping'
require 'rsaml/protocol/idp_list'
require 'rsaml/protocol/idp_entry'

require 'rsaml/protocol/assertion_id_request'
require 'rsaml/protocol/authn_request'

require 'rsaml/protocol/query'