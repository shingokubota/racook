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
