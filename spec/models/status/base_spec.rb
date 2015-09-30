RSpec.describe Status::Base do
  describe "#branch" do
    it "returns master" do
      base_status = Status::Base.new("jollygoodcode/dasherize")

      expect(base_status.branch).to eq "master"
    end
  end
end
