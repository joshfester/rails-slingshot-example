FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
  end
end
