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

10.times do |n|
   name = Faker::Football.player
   description = Faker::Lorem.paragraph(sentence_count = 3)
   picture = Faker::Avatar.image
   detail = Faker::Lorem.paragraph(sentence_count = 10)
   place = Faker::Address.city
   price = Faker::Number.between(from = 100, to = 1000)
   score = Faker::Number.between(from = 1.0, to = 10.0)
   count_views = Faker::Number.between(from = 1, to = 100)
   start_time = Time.zone.now
   finish_time = 20.days.from_now
   Tour.create!(name: name,
                description: description,
                picture: picture,
                detail: detail,
                place: place,
                price: price,
                score: score,
                count_views: count_views,
                start_time: start_time,
                finish_time: finish_time,
                max_slot: 10,
                category_id: 6)
end

10.times do |n|
   name = Faker::Football.player
   description = Faker::Lorem.paragraph(sentence_count = 3)
   picture = Faker::Avatar.image
   detail = Faker::Lorem.paragraph(sentence_count = 10)
   place = Faker::Address.city
   price = Faker::Number.between(from = 100, to = 1000)
   score = Faker::Number.between(from = 1.0, to = 10.0)
   count_views = Faker::Number.between(from = 1, to = 100)
   start_time = Time.zone.now
   finish_time = 20.days.from_now
   Tour.create!(name: name,
                description: description,
                picture: picture,
                detail: detail,
                place: place,
                price: price,
                score: score,
                count_views: count_views,
                start_time: start_time,
                finish_time: finish_time,
                max_slot: 10,
                category_id: 7)
end

10.times do |n|
   name = Faker::Football.player
   description = Faker::Lorem.paragraph(sentence_count = 3)
   picture = Faker::Avatar.image
   detail = Faker::Lorem.paragraph(sentence_count = 10)
   place = Faker::Address.city
   price = Faker::Number.between(from = 100, to = 1000)
   score = Faker::Number.between(from = 1.0, to = 10.0)
   count_views = Faker::Number.between(from = 1, to = 100)
   start_time = Time.zone.now
   finish_time = 20.days.from_now
   Tour.create!(name: name,
                description: description,
                picture: picture,
                detail: detail,
                place: place,
                price: price,
                score: score,
                count_views: count_views,
                start_time: start_time,
                finish_time: finish_time,
                max_slot: 10,
                category_id: 8)
end

10.times do |n|
   name = Faker::Football.player
   description = Faker::Lorem.paragraph(sentence_count = 3)
   picture = Faker::Avatar.image
   detail = Faker::Lorem.paragraph(sentence_count = 10)
   place = Faker::Address.city
   price = Faker::Number.between(from = 100, to = 1000)
   score = Faker::Number.between(from = 1.0, to = 10.0)
   count_views = Faker::Number.between(from = 1, to = 100)
   start_time = Time.zone.now
   finish_time = 20.days.from_now
   Tour.create!(name: name,
                description: description,
                picture: picture,
                detail: detail,
                place: place,
                price: price,
                score: score,
                count_views: count_views,
                start_time: start_time,
                finish_time: finish_time,
                max_slot: 10,
                category_id: 9)
end

10.times do |n|
   name = Faker::Football.player
   description = Faker::Lorem.paragraph(sentence_count = 3)
   picture = Faker::Avatar.image
   detail = Faker::Lorem.paragraph(sentence_count = 10)
   place = Faker::Address.city
   price = Faker::Number.between(from = 100, to = 1000)
   score = Faker::Number.between(from = 1.0, to = 10.0)
   count_views = Faker::Number.between(from = 1, to = 100)
   start_time = Time.zone.now
   finish_time = 20.days.from_now
   Tour.create!(name: name,
                description: description,
                picture: picture,
                detail: detail,
                place: place,
                price: price,
                score: score,
                count_views: count_views,
                start_time: start_time,
                finish_time: finish_time,
                max_slot: 10,
                category_id: 10)
end

50.times do |n|
   review_content = Faker::Lorem.paragraph(sentence_count = 3)
   count_liked = Faker::Number.between(from = 1, to = 100)
   comment_content = Faker::Lorem.paragraph(sentence_count = 3)
   rating_score = Faker::Number.between(from = 1, to = 10)
   user_id = Faker::Number.between(from = 2, to = 50)
   tour_id = Faker::Number.between(from = 1, to = 50)
   Review.create!(review_content: review_content,
                  review_at: Time.zone.now,
                  reply_review: 0,
                  count_liked: count_liked,
                  comment_content: comment_content,
                  comment_at: Time.zone.now,
                  reply_comment: 0,
                  rating_score: rating_score,
                  user_id: user_id,
                  tour_id: tour_id)
end

10.times do |n|
   Payment.create!(name: Faker::Name.name)
end
