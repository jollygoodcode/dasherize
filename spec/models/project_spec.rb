require "rails_helper"

RSpec.describe Project do
  context "associations" do
    it { is_expected.to belong_to :user }
  end

  context "validations" do
    it { is_expected.to validate_presence_of :repo_name }
  end
end
