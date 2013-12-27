require 'httparty'
require 'json'
require 'active_support/core_ext/hash'

class ConfirmarCompra
  include HTTParty
  base_uri "www.e-andreani.com:443"
  headers "Content-type" => ENV['CONTENT_TYPE_CONFIRMAR_COMPRA']

  def initialize(options = {})
    @calle                       = options[:calle]
    @categoria_distancia         = options[:categoria_distancia]
    @categoria_facturacion       = options[:categoria_facturacion]
    @categoria_peso              = options[:categoria_peso]
    @codigo_postal_destino       = options[:codigo_postal_destino]
    @contrato                    = options[:contrato]
    @departamento                = options[:departamento]
    @detalle_productos_entrega   = options[:detalle_productos_entrega]
    @detalle_productos_retiro    = options[:detalle_productos_retiro]
    @email                       = options[:email]
    @localidad                   = options[:localidad]
    @nombre_apellido             = options[:nombre_apellido]
    @nombre_apellido_alternativo = options[:nombre_apellido_alternativo]
    @numero                      = options[:numero]
    @numero_celular              = options[:numero_celular]
    @numero_documento            = options[:numero_documento]
    @numero_telefono             = options[:numero_telefono]
    @numero_transaccion          = options[:numero_transaccion]
    @peso                        = options[:peso]
    @piso                        = options[:piso]
    @provincia                   = options[:provincia]
    @sucursal_cliente            = options[:sucursal_cliente]
    @sucursal_retiro             = options[:sucursal_retiro]
    @tarifa                      = options[:tarifa]
    @tipo_documento              = options[:tipo_documento]
    @valor_a_cobrar              = options[:valor_a_cobrar]
    @valor_declarado             = options[:valor_declarado]
    @volumen                     = options[:volumen]
  end

  def result
    result = self.class.post(
                ENV['SOAP_CONFIRMAR_COMPRA'],
                body: data
              ).body

    hash_response = Hash.from_xml(result)
    hash_response.first.last["Body"]
  end

private
  def data
    body = <<-EOF
<and:ConfirmarCompra>
   <!--Optional:-->
   <and:compra>
      <and:Calle>#{@calle}</and:Calle>
      <and:CategoriaDistancia>#{@categoria_distancia}</and:CategoriaDistancia>
      <and:CategoriaFacturacion>#{@categoria_facturacion}</and:CategoriaFacturacion>
      <and:CategoriaPeso>#{@categoria_peso}</and:CategoriaPeso>
      <and:CodigoPostalDestino>#{@codigo_postal_destino}</and:CodigoPostalDestino>
      <and:Contrato>#{@contrato}</and:Contrato>
      <and:Departamento>#{@departamento}</and:Departamento>
      <and:DetalleProductosEntrega>#{@detalle_productos_entrega}</and:DetalleProductosEntrega>
      <and:DetalleProductosRetiro>#{@detalle_productos_retiro}</and:DetalleProductosRetiro>
      <and:Email>#{@email}</and:Email>
      <and:Localidad>#{@localidad}</and:Localidad>
      <and:NombreApellido>#{@nombre_apellido}</and:NombreApellido>
      <and:NombreApellidoAlternativo>#{@nombre_apellido_alternativo}</and:NombreApellidoAlternativo>
      <and:Numero>#{@numero}</and:Numero>
      <and:NumeroCelular>#{@numero_celular}</and:NumeroCelular>
      <and:NumeroDocumento>#{@numero_documento}</and:NumeroDocumento>
      <and:NumeroTelefono>#{@numero_telefono}</and:NumeroTelefono>
      <and:NumeroTransaccion>#{@numero_transaccion}</and:NumeroTransaccion>
      <and:Peso>#{@peso}</and:Peso>
      <and:Piso>#{@piso}</and:Piso>
      <and:Provincia>#{@provincia}</and:Provincia>
      <and:SucursalCliente>#{@sucursal_cliente}</and:SucursalCliente>
      <and:SucursalRetiro>#{@sucursal_retiro}</and:SucursalRetiro>
      <and:Tarifa>#{@tarifa}</and:Tarifa>
      <and:TipoDocumento>#{@tipo_documento}</and:TipoDocumento>
      <and:ValorACobrar>#{@valor_a_cobrar}</and:ValorACobrar>
      <and:ValorDeclarado>#{@valor_declarado}</and:ValorDeclarado>
      <and:Volumen>#{@volumen}</and:Volumen>
   </and:compra>
</and:ConfirmarCompra>
    EOF

    XmlRequest.new(body).document
  end
end
