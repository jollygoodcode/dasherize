RSpec.describe Status::Travis do
  describe "#status" do
    let(:travis) { Status::Travis.new("jollygoodcode/dasherize") }

    before do
      allow(HTTP).to receive(:headers) { spy }
      allow(JSON).to receive(:parse) { Hash("branch" => { "state" => api_result }) }
    end

    context "API returns 0" do
      let(:api_result) { "passed" }

      it "passed" do
        expect(travis.status).to eq :passed
      end
    end

    context "API returns 1" do
      let(:api_result) { "failed" }

      it "failed" do
        expect(travis.status).to eq :failed
      end
    end

    context "API returns anything else" do
      let(:api_result) { "anything" }

      it "waiting" do
        expect(travis.status).to eq :waiting
      end
    end
  end

  describe "#url" do
    let(:repo)      { "jollygoodcode/dasherize" }
    let(:build_id)  { "1234567890" }

    let(:travis)    { Status::Travis.new(repo) }

    before do
      allow(HTTP).to receive(:headers) { spy }
      allow(JSON).to receive(:parse) { Hash("branch" => { "id" => build_id }) }
    end

    it { expect(travis.url).to eq "https://travis-ci.org/#{repo}/builds/#{build_id}"}
  end
end
