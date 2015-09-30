FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "topsecret"
    password_confirmation "topsecret"

    trait :with_admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end

    trait :with_oauth_account do
      oauth_account
    end

    after(:create) do |user|
      user.confirm
    end
  end
end
