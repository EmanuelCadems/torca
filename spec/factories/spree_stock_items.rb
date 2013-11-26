FactoryGirl.define do
  factory :stock_item, class: Spree::StockItem do
    stock_location
    variant
    count_on_hand            1
  end
end
