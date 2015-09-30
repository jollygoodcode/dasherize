FactoryGirl.define do
  factory :project do
    repo_name      { Faker::Code.isbn }
    codeship_uuid  { Faker::Code.isbn }
  end

  trait :with_user do
    user
  end
end
