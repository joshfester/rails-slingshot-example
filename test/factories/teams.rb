FactoryBot.define do
  factory :team do
    sequence(:title) { |n| "Title #{n}" }
    owner { association :user }
  end
end
