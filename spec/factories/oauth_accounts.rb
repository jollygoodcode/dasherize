FactoryGirl.define do
  factory :oauth_account do
    user nil
    provider "github"
    uid "1234"
  end
end
