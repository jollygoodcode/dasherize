require "rails_helper"

RSpec.describe OauthAccount do
  context "associations" do
    it { is_expected.to belong_to(:user) }
  end

  let(:omniauth_json) { OmniAuth::AuthHash.new JSON.parse(IO.read("spec/fixtures/omniauth.json")) }
  let(:oauth_account) { OauthAccount.from_omniauth(omniauth_json) }

  describe ".from_omniauth" do
    it "should create OauthAccount + User" do
      expect(oauth_account).to be_kind_of(OauthAccount)
      expect(oauth_account).to be_persisted
    end

    it "should be associated with a user" do
      user = oauth_account.user

      expect(user).to be_kind_of(User)
      expect(user).to be_persisted
    end

    it "should retrieve existing OauthAccount and User" do
      oauth_account

      expect {
        oauth_account
      }.not_to change {
        OauthAccount.count
        User.count
      }
    end
  end

  describe "#oauth_token=" do
    it "encrypts" do
      cryptor = double
      expect(ActiveSupport::MessageEncryptor).to receive(:new).and_return(cryptor)

      expect(cryptor).to receive(:encrypt_and_sign)

      oauth_account
    end
  end

  describe "#oauth_token" do
    it "decrypts" do
      cryptor = double
      expect(ActiveSupport::MessageEncryptor).to receive(:new).and_return(cryptor)

      expect(cryptor).to receive(:encrypt_and_sign)

      oauth_account.oauth_token
    end
  end
end
