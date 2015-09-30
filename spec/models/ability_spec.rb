require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  context "admin" do
    let(:user) { create(:user, :with_admin) }

    it { is_expected.to be_able_to(:manage, :all) }
  end

  context "normal user" do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to(:crud, Project.new(user_id: user.id)) }
  end
end
