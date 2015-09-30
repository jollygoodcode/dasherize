require "rails_helper"

RSpec.describe User do
  context "associations" do
    it { is_expected.to have_one(:oauth_account) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "#role" do
    it "is nil when without a role" do
      user = create(:user)
      expect(user.role).to be_nil
    end

    it "returns the role" do
      user = create(:user)
      user.add_role :admin
      expect(user.role).to eq :admin
    end
  end

  describe "#role=" do
    it "sets role" do
      user = create(:user)
      user.role = :admin
      expect(user.role).to eq :admin
    end

    it "unsets a previous role" do
      user = create(:user)

      user.role = :admin
      expect(user.role).to eq :admin

      user.role = :supervisor
      expect(user.role).to eq :supervisor
    end
  end
end
