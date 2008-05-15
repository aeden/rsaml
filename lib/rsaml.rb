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

require 'rsaml/assertion'
require 'rsaml/authentication_context'
require 'rsaml/condition'
require 'rsaml/conditions'
require 'rsaml/encrypted'
require 'rsaml/errors'
require 'rsaml/identifier'
require 'rsaml/proxy_restriction'
require 'rsaml/signature'
require 'rsaml/statement'
require 'rsaml/subject'
require 'rsaml/subject_confirmation'
require 'rsaml/subject_confirmation_data'
require 'rsaml/subject_locality'