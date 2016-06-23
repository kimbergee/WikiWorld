require 'faker'

20.times do
  User.create!(
  email: Faker::Internet.email,
  username: Faker::Internet.user_name,
  password: Faker::Internet.password(8)
  )
end
users = User.all

20.times do
  Wiki.create!(
  user: users.sample,
  title: Faker::Superhero.name,
  body: Faker::Hipster.paragraph
  )
end
wikis = Wiki.all


premium = User.new(
    email: "premiumuser@test.com",
    password: "hello1234",
    username: "premiumuser",
    role: "premium"
)
premium.skip_confirmation!
premium.save!


standard = User.new(
    email: "standarduser@test.com",
    password: "hello1234",
    username: "standarduser",
    role: "standard"
)
standard.skip_confirmation!
standard.save!


admin = User.new(
  email: "kimber.gee@gmail.com",
  password: "hello1234",
  username: "kimber",
  role: "admin"
)
admin.skip_confirmation!
admin.save!


puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
