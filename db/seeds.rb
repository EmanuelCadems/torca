PROVINCES = [
  ['Ciudad de Buenos Aires', 'DF'],
  ['Buenos Aires',           'BA'],
  ['Catamarca',              'CT'],
  ['Chaco',                  'CC'],
  ['Chubut',                 'CH'],
  ['Córdoba',                'CD'],
  ['Corrientes',             'CR'],
  ['Entre Ríos',             'ER'],
  ['Formosa',                'FO'],
  ['Jujuy',                  'JY'],
  ['La Pampa',               'LP'],
  ['La Rioja',               'LR'],
  ['Mendoza',                'MZ'],
  ['Misiones',               'MN'],
  ['Neuquén',                'NQ'],
  ['Río Negro',              'RN'],
  ['Salta',                  'SA'],
  ['San Juan',               'SJ'],
  ['San Luis',               'SL'],
  ['Santa Cruz',             'SC'],
  ['Santa Fe',               'SF'],
  ['Santiago del Estero',    'SE'],
  ['Tucumán',                'TF']
]

SHIPPING_METHODS = [
  ['Retira en Sucursal',   'ReS'],
  ['Recibir en Domicilio', 'ReD'],
]

STOCK_LOCATIONS = [
  [12, 'Rawson', 'Sucursal Rawson', 'CHUBUT', 'Gregorio Mayo 242, Rawson, Chubut.'],
  [14, 'Esquel', 'Sucursal Esquel', 'CHUBUT', '25 de Mayo 783, Esquel, Chubut.'],
  [15, 'Madryn', 'Sucursal Madryn', 'CHUBUT', 'Bmé. Mitre 401 esq. 9 de Julio, Puerto Madryn, Chubut.'],
  [21, 'Trelew', 'Sucursal Trelew', 'CHUBUT', 'Sarmiento 223, Trelew, Chubut.'],
  [25, 'Sarmiento', 'Sucursal Sarmiento', 'CHUBUT', 'Ingeniero Coronel Nº 291 y España Nº 717, Sarmiento, Chubut.'],
  [30, 'Comodoro Rivadavia', 'Sucursal Comodoro Rivadavia', 'CHUBUT', 'Hipólito Yrigoyen 2801 esq. Av. Roca, Comodoro Rivadavia, Pcia. Del Chubut.'],
  [31, 'Pico Truncado', 'Sucursal Pico Truncado', 'SANTA CRUZ', 'Mariano Moreno 340, Pico Truncado, Pcia. De Santa Cruz.'],
  [32, 'Caleta Olivia', 'Sucursal Caleta Olivia', 'SANTA CRUZ', 'Av. Lisandro de la Torre Nº 1 esq. Av. Independencia Nº 15, Caleta Olivia, Pcia. De Santa Cruz.'],
  [33, 'Las Heras', 'Sucursal Las Heras', 'SANTA CRUZ', 'San Martin 290 esq. Bernardino Rivadavia, Las Heras, Santa Cruz.'],
  [34, 'Puerto Deseado', 'Sucursal Puerto Deseado', 'SANTA CRUZ', 'San Martín 973, Puerto Deseado, Pcia. De Santa Cruz.'],
  [90, 'Centro de Distribución', 'Administración Central TORCA S.A.', 'CHUBUT', 'Sarmiento 223, Trelew, Chubut.'],
  [91,  'MACER S.A. (Centro de Distribución)', 'Administración Central MACER S.A.', 'CHUBUT', 'Sarmiento 223, Trelew, Chubut.'],
  [1201, 'Rawson (Centro de Distribución)', 'Sucursal Rawson', 'CHUBUT', 'Gregorio Mayo 242, Rawson, Chubut.'],
  [1401, 'Venta al Interior (Esquel)', 'Sucursal Esquel', 'CHUBUT', '25 de Mayo 783, Esquel, Chubut.'],
  [2101, 'Trelew (Centro de Distribución)', 'Sucursal Trelew', 'CHUBUT', 'Sarmiento 223, Trelew, Chubut.'],
  [2501, 'Sarmiento (Externo)', 'Sucursal Sarmiento', 'CHUBUT', 'Ingeniero Coronel Nº 291 y España Nº 717, Sarmiento, Chubut.']
]

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

country = Spree::Country.where(name: 'Argentina').first

PROVINCES.each do |p|
  Spree::State.create!(name: p[0].upcase, abbr: p[1], country_id: country.id)
end

z = Spree::Zone.create!(name: 'Argentina',kind: 'country', country_ids:["", country.id.to_s])

SHIPPING_METHODS.each do |sm|
  Spree::ShippingMethod.create!(
    name: sm[0],
    admin_name: sm[1],
    shipping_categories: [Spree::ShippingCategory.first],
    zones: [z],
    calculator_type: "Spree::Calculator::Shipping::FlatPercentItemTotal"
  )
end

# sm.calculator_type = Spree::ShippingMethod.calculators.first
# sm.calculator = Spree::Calculator::Shipping::FlatPercentItemTotal.first
# sm.shipping_rates.build(cost: 0.0)
# sm.zones << country
# sm.shipping_method_categories << Spree::ShippingCategory.first

STOCK_LOCATIONS.each do |sl|
  state = Spree::State.where(name: sl[3]).first

  Spree::StockLocation.create!(
    admin_name:              sl[1],
    name:                    sl[2] + ' ' + sl[4],
    address1:                sl[4],
    city:                    sl[1],
    state_id:                state.id,
    country_id:              country.id
    )
end
