FactoryBot.define do
  factory :tour, class: Tour do
    name {Faker::Name.name}
    description {Faker::Lorem.paragraph(sentence_count = 3)}
    picture {Faker::Avatar.image}
    detail {Faker::Lorem.paragraph(sentence_count = 10)}
    place {Faker::Address.city}
    price {Faker::Number.between(from = 100, to = 1000)}
    start_time {Time.zone.now}
    finish_time {Time.zone.now}
    status {"openning"}
    category_id { 1 }
  end
end
