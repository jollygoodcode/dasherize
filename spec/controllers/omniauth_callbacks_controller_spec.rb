require "rails_helper"

RSpec.describe OmniauthCallbacksController do
  let(:user) { create(:user, :with_oauth_account) }

  def do_request
    get :github
  end

  before { request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "#callback" do
    context "existing user" do
      before do
        expect(OauthAccount).to receive(:from_omniauth) { double(user: user) }
      end

      it "works" do
        do_request
        is_expected.to set_flash[:notice].to "Successfully authenticated from Github account."
        expect(response).to redirect_to root_path
      end
    end

    context "new user" do
      let(:user_info) do
        double(
          :user,
          name: "Audrey",
          email: "audrey@example.com",
          oauth_account: double(oauth_token: "token")
        )
      end

      it "creates new user" do
        request.env["omniauth.auth"] = stub_oauth(user_info)

        do_request

        expect(User.count).to eq 1
        expect(User.last).to have_attributes(name: "Audrey", email: "audrey@example.com")
      end
    end
  end
end
