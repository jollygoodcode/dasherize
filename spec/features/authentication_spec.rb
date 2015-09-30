require "feature_helper"

RSpec.feature "Authentication" do
  background { Rails.cache.clear }

  scenario "sign in" do
    stub_ci_requests_for_home_page
    user = create(:user, :with_oauth_account)

    sign_in_as(user)

    expect(page).to have_content(user.name)
  end

  scenario "sign out" do
    stub_ci_requests_for_home_page
    user = create(:user, :with_oauth_account)
    sign_in_as(user)

    sign_out_user

    expect(page).not_to have_content(user.name)
  end
end
