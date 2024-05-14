FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    genre { Faker::Book.genre }
    isbn { Faker::Number.number(digits: 13) }
    total_copies { 5 }
  end
end
