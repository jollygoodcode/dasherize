require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  context "normal user" do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to(:crud, Project.new(user_id: user.id)) }
  end
end
