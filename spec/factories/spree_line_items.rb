FactoryGirl.define do
  factory :line_item, class: Spree::LineItem do
    variant
    order
    quantity  3
    price     5
    currency "USD"
  end
end
