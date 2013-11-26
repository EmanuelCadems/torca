FactoryGirl.define do
  factory :product, class: Spree::Product do
    name                 "AURICULAR EURO EUHP-005 ATENAS C/MICROFONO"
    description          "Any description"
    price                5.0
    available_on         Date.today
    deleted_at           nil
    permalink            "auricular-euro-euhp-005-atenas-c-slash-microfono"
    meta_description     nil
    meta_keywords        nil
    shipping_category_id 1
  end
end
