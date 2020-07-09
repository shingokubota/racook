FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    description { "テスト" }
    portion { 2.0 }
    reference { "https://cookpad.com/pro/recipes/3995827" }
    cooking_time { 30 }
    popularity { 1 }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :one_year_ago do
    created_at { 1.year.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_dish.jpg')) }
  end
end
