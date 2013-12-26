class XmlRequest
  attr_accessor :document

  def initialize(body)
    self.document = <<-EOF
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:and="http://www.andreani.com.ar">
   <soap:Header>
    <wsse:Security soap:mustUnderstand="true" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
     <wsse:UsernameToken>

      <wsse:Username>#{ENV['SOAP_USER']}</wsse:Username>
      <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">#{ENV['SOAP_PASSWORD']}</wsse:Password>
     </wsse:UsernameToken>
    </wsse:Security>
   </soap:Header>
   <soap:Body>
      #{body}
   </soap:Body>
</soap:Envelope>
    EOF
  end
end
