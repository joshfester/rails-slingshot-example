FactoryBot.define do
  factory :membership do
    role { :member }

    trait :with_user do
      user { association :user }
    end

    trait :with_team do
      team { association :team }
    end

    trait :admin do
      role { "admin" }
    end
  end
end
