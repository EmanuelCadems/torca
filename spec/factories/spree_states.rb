FactoryGirl.define do
  factory :state, class: Spree::State do
    country

    name  "CHUBUT"
    abbr  "CH"
  end
end
