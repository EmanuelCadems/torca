require "spec_helper"

feature "Cotizar Envio" do
  scenario "Cotizar " do
    cotizar_envio = CotizarEnvio.new(
                      cp_destino: 1828,
                      cliente: "CL0003750",
                      contrato: 300005270,
                      peso: 500,
                      sucursal_retiro: 56,
                      valor_declarado: 150,
                      volumen: 1000
                    )

    expect(cotizar_envio.result).to eql(
      {
        "xmlns:i"              => "http://www.w3.org/2001/XMLSchema-instance",
        "CategoriaDistancia"   => "AMBA (hasta 60km)",
        "CategoriaDistanciaId" => {"i:nil"=>"true"},
        "CategoriaPeso"        => "1",
        "CategoriaPesoId"      => {"i:nil"=>"true"},
        "PesoAforado"          => "500",
        "Tarifa"               => "26.00"
      }
    )
  end
end
