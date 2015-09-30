RSpec.describe Status::Travis do
  describe "#status" do
    let(:travis) { Status::Travis.new("jollygoodcode/dasherize") }

    before do
      allow(HTTP).to receive(:get)
      allow(JSON).to receive(:parse) { Hash("last_build_status" => api_result) }
    end

    context "API returns 0" do
      let(:api_result) { 0 }

      it "passed" do
        expect(travis.status).to eq :passed
      end
    end

    context "API returns 1" do
      let(:api_result) { 1 }

      it "failed" do
        expect(travis.status).to eq :failed
      end
    end

    context "API returns anything else" do
      let(:api_result) { 2 }

      it "waiting" do
        expect(travis.status).to eq :waiting
      end
    end
  end
end
