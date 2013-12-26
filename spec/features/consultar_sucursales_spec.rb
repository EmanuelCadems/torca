require 'spec_helper'

feature 'ConsultarSucursales request' do
  context 'with broad query' do
    scenario 'returns the branch offices that match with criteria search' do
      response = ConsultarSucursales.new(provincia: "CHUBUT").result

      expect(response.first["Descripcion"]).to eq "COMODORO RIVADAVIA"
      expect(response.last["Descripcion"]).to  eq "TRELEW"
    end
  end

  context 'with specific query' do
    scenario 'returns an array with the branch office that match with criteria search' do
      response = ConsultarSucursales.new(
                   provincia: "CHUBUT",
                   codigo_postal: 9000
                 ).result

      expect(response).to eql [
        {
          "Descripcion"   => "COMODORO RIVADAVIA",
          "Direccion"     => "Dorrego 725 , 9000 , COMODORO RIVADAVIA , CHUBUT",
          "HoradeTrabajo" => {"i:nil"=>"true"},
          "Latitud"       => {"i:nil"=>"true"},
          "Longitud"      => {"i:nil"=>"true"},
          "Mail"          => "opercrivadavia@andreani.com.ar",
          "Numero"        => "CRD",
          "Responsable"   => {"i:nil"=>"true"},
          "Resumen"       => "COMODORO RIVADAVIA",
          "Sucursal"      => "26",
          "Telefono1"     => {"i:nil"=>"true"},
          "Telefono2"     => {"i:nil"=>"true"},
          "Telefono3"     => {"i:nil"=>"true"},
          "TipoSucursal"  => "2",
          "TipoTelefono1" => {"i:nil"=>"true"},
          "TipoTelefono2" => {"i:nil"=>"true"},
          "TipoTelefono3" => {"i:nil"=>"true"}
        }
      ]
    end
  end
end
