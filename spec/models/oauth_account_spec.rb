require "rails_helper"

RSpec.describe OauthAccount do
  context "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "#from_omniauth" do
    let(:omniauth_json) do
      OmniAuth::AuthHash.new JSON.parse(IO.read("spec/fixtures/omniauth.json"))
    end

    it "should create OauthAccount + User" do
      oauth_account = OauthAccount.from_omniauth(omniauth_json)

      expect(oauth_account).to be_kind_of(OauthAccount)
      expect(oauth_account).to be_persisted
    end

    it "should be associated with a user" do
      user = OauthAccount.from_omniauth(omniauth_json).user

      expect(user).to be_kind_of(User)
      expect(user).to be_persisted
    end

    it "should retrieve existing OauthAccount and User" do
      OauthAccount.from_omniauth(omniauth_json)

      expect {
        OauthAccount.from_omniauth(omniauth_json)
      }.not_to change {
        OauthAccount.count
        User.count
      }
    end
  end
end
