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

$:.unshift(File.dirname(__FILE__))

require 'rsaml/assertion'
require 'rsaml/encrypted'
require 'rsaml/identifier'
require 'rsaml/statement'
require 'rsaml/signature'