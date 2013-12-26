require 'httparty'
require 'json'
require 'active_support/core_ext/hash'

class ConsultarSucursales
  include HTTParty
  base_uri "www.e-andreani.com:443"
  headers "Content-type" => ENV['CONTENT_TYPE_CONSULTAR_SUCURSALES']

  def initialize(options = {})
    @codigo_postal = options[:codigo_postal]
    @localidad     = options[:localidad]
    @provincia     = options[:provincia]
  end

  def result
    result = self.class.post(
              ENV['SOAP_CONSULTAR_SUCURSALES'],
              body: data
             ).body

    hash_response = Hash.from_xml(result)
    sucursales = hash_response.first.last["Body"]["ConsultarSucursalesResponse"]["ConsultarSucursalesResult"]["ResultadoConsultarSucursales"]

    if sucursales.is_a?(Hash)
      sucursales = [sucursales]
    else
      sucursales
    end
  end

private
  def data
    body = <<-EOF
<and:ConsultarSucursales>
   <and:consulta>
      <and:CodigoPostal>#{@codigo_postal}</and:CodigoPostal>
      <and:Localidad>#{@localidad}</and:Localidad>
      <and:Provincia>#{@provincia}</and:Provincia>
   </and:consulta>
</and:ConsultarSucursales>
    EOF

    XmlRequest.new(body).document
  end
end
