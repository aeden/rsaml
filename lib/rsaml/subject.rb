module RSAML #:nodoc:
  # Specifies the principal that is the subject of all of the (zero or more) 
  # statements in an assertion.
  class Subject
    
    # The subject identifier
    attr_accessor :identifier
    
    # Initialize the subject with the given identifier
    def initialize(identifier=nil)
      @identifier = identifier
    end
    
    # Information that allows the subject to be confirmed. If more than one subject confirmation is provided, 
    # then satisfying any one of them is sufficient to confirm the subject for the purpose of applying the 
    # assertion.
    def subject_confirmations
      @subject_confirmations ||= []
    end
    
    # Construct an XML fragment representing the subject
    def to_xml(xml=Builder::XmlMarkup.new)
      xml.tag!('saml:Subject') {
        xml << identifier.to_xml unless identifier.nil?
        xml << subject_confirmations.map { |sc| sc.to_xml }.join
      }
    end
    
    # Construct a Subject from an XML Element.
    def self.from_xml(element)
      element = REXML::Document.new(element).root if element.is_a?(String)      
      element.get_elements('saml:NameID').each do |identifier|
        return Subject.new(Identifier::Name.from_xml(identifier))
      end
    end
  end
end