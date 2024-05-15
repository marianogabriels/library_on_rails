FactoryBot.define do
  factory :borrow do
    association :user
    association :book
    due_at { 2.weeks.from_now }
    returned_at { nil }
  end
end
