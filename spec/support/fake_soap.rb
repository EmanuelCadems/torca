require 'sinatra/base'

class FakeSoap < Sinatra::Base
  post '/CasaStaging/ecommerce/ConsultaSucursales.svc/soap12' do
    query = get_query

    case [query["Provincia"],query["CodigoPostal"]]
    when ["CHUBUT", "9000"]
      xml_response 200, 'sucursal.xml'
    when ["CHUBUT", nil]
      xml_response 200, 'sucursales.xml'
    else
      nil
    end
  end

  post '/CasaStaging/ecommerce/CotizacionEnvio.svc/soap12' do
    xml_response 200, 'response_cotizar_envio.xml'
  end

private

  def xml_response(response_code, file_name)
    content_type :xml
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end

  def get_query
    get_request = Hash.from_xml(request.env["rack.input"].read)
    get_request["Envelope"]["Body"]["ConsultarSucursales"]["consulta"]
  end
end
