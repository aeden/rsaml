module RSAML #:nodoc:
  module Protocol #:nodoc:
    # specifies the identity providers trusted by the requester to authenticate the presenter, as well as 
    # limitations and context related to proxying of the <AuthnRequest> message to subsequent identity 
    # providers by the responder.
    class Scoping
      # Specifies the number of proxying indirections permissible between the identity provider that receives 
      # this <AuthnRequest> and the identity provider who ultimately authenticates the principal. A count of 
      # zero permits no proxying, while omitting this attribute expresses no such restriction.
      attr_accessor :proxy_count
      
      # An advisory list of identity providers and associated information that the requester deems acceptable 
      # to respond to the request.
      attr_accessor :idp_list
      
      # Identifies the set of requesting entities on whose behalf the requester is acting. Used to communicate 
      # the chain of requesters when proxying occurs.
      def requestor_ids
        @requestor_ids ||= []
      end
      
      # Construct an XML fragment representing the scoping
      def to_xml(xml=Builder::XmlMarkup.new)
        attributes = {}
        attributes['ProxyCount'] = proxy_count if proxy_count
        xml.tag!('samlp:Scoping', attributes) {
          xml << idp_list.to_xml if idp_list
          requestor_ids.each { |requestor_id| xml << requestor_id.to_xml }
        }
      end
    end
  end
end