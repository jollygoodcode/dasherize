RSpec.describe Status::Codeship do
  let(:failure_messages) do
    %i(error projectnotfound branchnotfound ignored stopped infrastructure_failure)
  end

  describe "#status" do
    let(:codeship) { Status::Codeship.new("jollygoodcode/dasherize") }

    before do
      allow(Codeship::Status).to receive(:new) { double(status: api_result) }
    end

    context "API returns success" do
      let(:api_result) { :success }

      it "passed" do
        expect(codeship.status).to eq :passed
      end
    end

    context "API returns one of the failure messages" do
      let(:api_result) { failure_messages.sample }

      it "failed" do
        expect(codeship.status).to eq :failed
      end
    end

    context "API returns anything else" do
      let(:api_result) { :hacking }

      it "waiting" do
        expect(codeship.status).to eq :waiting
      end
    end
  end
end
