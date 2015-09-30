require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#status_class" do
    subject(:status_class) { helper.status_class(status) }

    context "unavailable" do
      let(:status) { :unavailable }

      it { expect(status_class).to eq "card-default" }
    end

    context "passed" do
      let(:status) { :passed }

      it { expect(status_class).to eq "card-success" }
    end

    context "waiting" do
      let(:status) { :waiting }

      it { expect(status_class).to eq "card-in-progress" }
    end

    context "failed" do
      let(:status) { :anything }

      it { expect(status_class).to eq "card-failure" }
    end
  end

  describe "#status_text" do
    subject(:status_text) { helper.status_text(status) }

    context "unavailable" do
      let(:status) { :unavailable }

      it { expect(status_text).to eq "Project does not have a CI status" }
    end

    context "passed" do
      let(:status) { :passed }

      it { expect(status_text).to eq "All specs passing on Master branch" }
    end

    context "waiting" do
      let(:status) { :waiting }

      it { expect(status_text).to eq "" }
    end

    context "failed" do
      let(:status) { :anything }

      it { expect(status_text).to eq "A few specs failing on Master branch" }
    end
  end
end
