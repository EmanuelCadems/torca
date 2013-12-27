require 'httparty'
require 'json'
require 'active_support/core_ext/hash'

class CotizarEnvio
  include HTTParty
  base_uri "www.e-andreani.com:443"
  headers "Content-type" => ENV['CONTENT_TYPE_COTIZAR_ENVIO']

  def initialize(options = {})
    @cp_destino      = options[:cp_destino]
    @cliente         = options[:cliente]
    @contrato        = options[:contrato]
    @peso            = options[:peso]
    @sucursal_retiro = options[:sucursal_retiro]
    @valor_declarado = options[:valor_declarado]
    @volumen         = options[:volumen]
  end

  def result
    result = self.class.post(
                ENV['SOAP_COTIZAR_ENVIO'],
                body: data
              ).body

    hash_response = Hash.from_xml(result)
    hash_response.first.last["Body"]["CotizarEnvioResponse"]["CotizarEnvioResult"]
  end

private
  def data
    body = <<-EOF
<and:CotizarEnvio>
   <!--Optional:-->
   <and:cotizacionEnvio>
      <and:CPDestino>#{@cp_destino}</and:CPDestino>
      <and:Cliente>#{@cliente}</and:Cliente>
      <and:Contrato>#{@contrato}</and:Contrato>
      <and:Peso>#{@peso}</and:Peso>
      <and:SucursalRetiro>#{@sucursal_retiro}</and:SucursalRetiro>
      <!--Optional:-->
      <and:ValorDeclarado>#{@valor_declarado}</and:ValorDeclarado>
      <and:Volumen>#{@volumen}</and:Volumen>
   </and:cotizacionEnvio>
</and:CotizarEnvio>
    EOF

    XmlRequest.new(body).document
  end
end
