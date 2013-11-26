FactoryGirl.define do
  factory :stock_location, class: Spree::StockLocation do
    state
    country
    name                    "Sucursal Rawson Gregorio Mayo 242, Rawson, Chubut."
    address1                "Gregorio Mayo 242, Rawson, Chubut."
    city                    "Rawson"
    active                  true
    backorderable_default   false
    propagate_all_variants  true
    admin_name              "Rawson"
  end
end
