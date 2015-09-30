require "feature_helper"

RSpec.feature "Adds a New Project" do
  background { Rails.cache.clear }

  scenario "works" do
    stub_ci_requests_for_home_page
    user = create(:user, :with_oauth_account)

    sign_in_as(user)
    visit root_path

    expect(page).not_to have_content "twemoji"

    within "[data-spec=new-project]" do
      click_on "New Project"
    end

    fill_in "Full Repository Name", with: "jollygoodcode/twemoji"
    select "travis", from: "project[ci_type]"
    click_on "Create Project"

    expect(page).to have_content "twemoji"
  end
end
