class RSAMLTest < Test::Unit::TestCase
  context "the RSAML module" do
    should "provide the SAML namespaces" do
      assert_equal 'urn:oasis:names:tc:SAML:2.0:assertion', RSAML::saml_namespaces['saml']
      assert_equal 'urn:oasis:names:tc:SAML:2.0:protocol', RSAML::saml_namespaces['samlp']
      assert_equal 'http://www.w3.org/2000/09/xmldsig#', RSAML::saml_namespaces['ds']
      assert_equal 'http://www.w3.org/2001/04/xmlenc#', RSAML::saml_namespaces['xenc']
      assert_equal 'http://www.w3.org/2001/XMLSchema', RSAML::saml_namespaces['xs']
      assert_equal 'http://www.w3.org/2001/XMLSchema-instance', RSAML::saml_namespaces['xsi']
    end
  end
end