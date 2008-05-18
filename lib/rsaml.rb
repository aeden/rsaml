SAML_NAMESPACES = {
  'saml' => 'urn:oasis:names:tc:SAML:2.0:assertion',
  'samlp' => 'urn:oasis:names:tc:SAML:2.0:protocol',
  'ds' => 'http://www.w3.org/2000/09/xmldsig#',
  'xenc' => 'http://www.w3.org/2001/04/xmlenc#',
  'xs' => 'http://www.w3.org/2001/XMLSchema',
  'xsi' => 'http://www.w3.org/2001/XMLSchema-instance'
}

require 'rubygems'
require 'uuid'
require 'activesupport'

$:.unshift(File.dirname(__FILE__))

require 'rsaml/ext/string'

require 'rsaml/encrypted'
require 'rsaml/validator'
require 'rsaml/errors'

require 'rsaml/action'
require 'rsaml/action_namespace'
require 'rsaml/advice'
require 'rsaml/assertion'
require 'rsaml/attribute'
require 'rsaml/audience'
require 'rsaml/authentication_context'
require 'rsaml/condition'
require 'rsaml/conditions'
require 'rsaml/evidence'
require 'rsaml/identifier'
require 'rsaml/proxy_restriction'
require 'rsaml/signature'
require 'rsaml/statement'
require 'rsaml/subject'
require 'rsaml/subject_confirmation'
require 'rsaml/subject_confirmation_data'
require 'rsaml/subject_locality'