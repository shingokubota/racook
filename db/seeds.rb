User.create!(name: "テスト 太郎",
             email: "test@example.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true
)

99.times do |n|
  name = Faker::Name.name
  email = "test#{n}@example.com"
  password = "foobar"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

10.times do |n|
  Dish.create!(name: Faker::Food.dish,
               description: "テスト料理",
               portion: 2.0,
               reference: "https://cookpad.com/recipe/5217458",
               cooking_time: 40,
               popularity: 4,
               user_id: 1)
end
