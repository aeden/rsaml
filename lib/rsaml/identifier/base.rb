module RSAML #:nodoc:
  module Identifier # :nodoc:
    # An extension point that allows applications to add new kinds of identifiers.
    class Base
      # The security or administrative domain that qualifies the name. This attribute provides a means to 
      # federate names from disparate user stores without collision.
      attr_accessor :name_qualifier
    
      # Further qualifies a name with the name of a service provider or affiliation of providers. This 
      # attribute provides an additional means to federate names on the basis of the relying party or 
      # parties.
      attr_accessor :sp_name_qualifier
    
      # Create an XML fragment representing the identifier
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['NameQualifier'] = name_qualifier unless name_qualifier.nil?
        attributes['SPNameQualifier'] = sp_name_qualifier unless sp_name_qualifier.nil?
        xml.tag!('BaseID', '', attributes)
      end
    end
  end
end