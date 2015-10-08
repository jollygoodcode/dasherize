RSpec.describe Status::Codeship do
  describe "#status" do
    let(:codeship) { Status::Codeship.new("jollygoodcode/dasherize").run! }

    let(:failure_messages) do
      %i(error projectnotfound branchnotfound ignored stopped infrastructure_failure)
    end

    before { allow(Codeship::Status).to receive(:new) { double(status: api_result) } }

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

  # Codeship doesn't have an api that could easily return the build url
  # If we have to implement this, we would first need to know the Codeship ID of the project
  # which means storing another field in the database -> not something we want..
  # Hence best effort for now is at least to link to Codeship
  describe "#url" do
    let(:codeship) { Status::Codeship.new("jollygoodcode/dasherize").run! }

    it { expect(codeship.url).to eq "https://codeship.com/projects" }
  end
end
