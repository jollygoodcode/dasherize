require "rails_helper"

RSpec.describe User do
  context "associations" do
    it { is_expected.to have_one(:oauth_account) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
