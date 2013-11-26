FactoryGirl.define do
  factory :variant, class: Spree::Variant do
    product

    # sku            "﻿55182"
    is_master      true
    position       1
    cost_currency  "USD"
  end
end
