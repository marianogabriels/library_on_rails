FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'ValidPassword123' }
  end
end
