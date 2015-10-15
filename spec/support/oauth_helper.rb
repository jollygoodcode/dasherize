module OAuthHelper
  def sign_in_as(user)
    stub_oauth(user)
    visit root_path
    within "[data-spec=sign-in]" do
      click_link "Sign In with GitHub"
    end
  end

  def sign_out_user
    within "[data-spec=sign-out]" do
      find(%{a[href="/users/sign_out"]}).click
    end
  end

  def stub_oauth(user)
    OmniAuth.config.add_mock(
      :github,
      info: { name: user.name, email: user.email },
      credentials: { token: user.oauth_account.oauth_token }
    )
  end
end
