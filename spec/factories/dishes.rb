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

  trait :ingredients do
    ingredients_attributes {
      [
        { name: "肉", quantity: "1枚" },
        { name: "ピーマン", quantity: "2個" },
        { name: "エリンギ", quantity: "1個" },
        { name: "みりん", quantity: "大さじ少々" },
        { name: "塩", quantity: "適宜" },
        { name: "胡椒", quantity: "小さじ少々" },
        { name: "胡麻", quantity: "適宜" },
        { name: "ごま油", quantity: "小さじ３杯" },
        { name: "マヨネーズ", quantity: "お好み" },
        { name: "たこ焼き", quantity: "1個" },
      ]
    }
  end
end
