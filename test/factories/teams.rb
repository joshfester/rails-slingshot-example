FactoryBot.define do
  factory :team do
    sequence(:title) { |n| "Title #{n}" }
  end
end
