# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Admin",
             email: "admin@gmail.com",
             phone: "0987654321",
             password: "123456",
             password_confirmation: "123456",
             role: 1)

50.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@example.com"
  phone = "0987523#{n+1}"
  password = "123456"
  User.create!(name: name,
               email: email,
               phone: phone,
               password: password,
               password_confirmation: password)
end

5.times do |n|
   name = Faker::Games::Dota.team
  Category.create!(name: name,
                   parent_id: 0)
end

5.times do |n|
   name = Faker::Games::Dota.team
  Category.create!(name: name,
                   parent_id: 1)
end
