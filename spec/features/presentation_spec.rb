require "feature_helper"

RSpec.feature "Presentation" do
  background { Rails.cache.clear }

  scenario "works" do
    stub_ci_requests_for_home_page
    user = create(:user, :with_oauth_account)
    create(:project, repo_name: "jollygoodcode/twemoji", user: user)
    create(:project, repo_name: "jollygoodcode/dasherize", user: user)
    sign_in_as(user)

    visit root_path
    within "[data-spec=presentation]" do
      click_on "Presentation"
    end

    expect(page).to have_content("jollygoodcode/twemoji")
    expect(page).to have_content("jollygoodcode/dasherize")
  end
end
