FactoryBot.define do
  factory :ingredient do
    name { "鶏肉" }
    quantity { "150g" }
    association :dish
  end
end
