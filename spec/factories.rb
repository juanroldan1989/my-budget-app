FactoryGirl.define do
  factory :deal do
    title     Faker::Commerce.product_name
    price     Faker::Number.between(1, 100)
    deal_type "single"
  end
end
