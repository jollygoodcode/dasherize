RSpec.describe Status::Circleci do
  describe "#status" do
    let(:circleci) { Status::Circleci.new("mtchavez/circleci") }

    let(:failure_messages) do
      %w(retried canceled infrastructure_fail timedout failed no_tests)
    end

    let(:waiting_messages) do
      %w(not_run running queued scheduled not_running)
    end

    before do
      allow(HTTP).to receive(:headers) { spy }
      allow(JSON).to receive(:parse) { [{ "branch" => "master", "status" => api_result }] }
    end

    context "API returns success" do
      let(:api_result) { "success" }

      it "passed" do
        expect(circleci.status).to eq :passed
      end
    end

    context "API returns one of the failure messages" do
      let(:api_result) { failure_messages.sample }

      it "failed" do
        expect(circleci.status).to eq :failed
      end
    end

    context "API returns anything else" do
      let(:api_result) { waiting_messages.sample }

      it "waiting" do
        expect(circleci.status).to eq :waiting
      end
    end
  end

  describe "#url" do
    let(:circleci) { Status::Circleci.new("mtchavez/circleci") }

    before do
      allow(HTTP).to receive(:headers) { spy }
      allow(JSON).to receive(:parse) { [{ "branch" => "master", "build_url" => "https://circleci.com" }] }
    end

    it { expect(circleci.url).to eq "https://circleci.com" }
  end
end
