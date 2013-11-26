FactoryGirl.define do
  factory :country, class: Spree::Country do
    iso_name        "ARGENTINA"
    iso             "AR"
    iso3            "ARG"
    name            "Argentina"
    numcode         32
    states_required true
  end
end
