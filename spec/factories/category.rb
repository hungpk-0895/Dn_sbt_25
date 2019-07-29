FactoryBot.define do
  factory :category1, class: Category do
    id {1}
    name {Faker::Name.name}
    parent_id {0}
  end

  factory :category2, class: Category do
    id {2}
    name {Faker::Name.name}
    parent_id {0}
  end
end
