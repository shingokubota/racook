FactoryBot.define do
  factory :favorite do
    association :user
    association :dish
  end
end
