RSpec.describe ProjectDecorator do
  subject { ProjectDecorator.new(project) }

  describe "#process_with" do
    let(:project) { build(:project) }

    it "invokes Parallel" do
      allow(Parallel).to receive(:each) { spy }

      subject.process_with

      expect(Parallel).to have_received(:each)
    end
  end

  describe "#org_user" do
    let(:project) { build(:project, repo_name: "jollygoodcode/dasherize") }

    it "returns first of project's repo name" do
      expect(subject.org_user).to eq "jollygoodcode"
    end
  end

  describe "#name" do
    let(:project) { build(:project, repo_name: "jollygoodcode/dasherize") }

    it "returns last of project's repo name" do
      expect(subject.name).to eq "dasherize"
    end
  end

  describe "#url" do
    let(:project) { build(:project, repo_name: "jollygoodcode/dasherize") }

    it "returns url based on project's repo name" do
      expect(subject.url).to eq "https://github.com/jollygoodcode/dasherize"
    end
  end

  describe "#pull_requests_url" do
    let(:project) { build(:project, repo_name: "jollygoodcode/dasherize") }

    it "returns Pull Requests url based on project's repo name" do
      expect(subject.pull_requests_url).to eq "https://github.com/jollygoodcode/dasherize/pulls"
    end
  end

  describe "#issues_url" do
    let(:project) { build(:project, repo_name: "jollygoodcode/dasherize") }

    it "returns Issues url based on project's repo name" do
      expect(subject.issues_url).to eq "https://github.com/jollygoodcode/dasherize/issues"
    end
  end

  describe "#pull_requests" do
    let(:project) { build(:project) }
    let(:pull_request) { double("Pull Request", pull_request: true) }
    let(:issue) { double("Issue", pull_request: false) }

    it "returns issue responds to pull_request" do
      expect(Octokit::Client).to receive(:new) { double(issues: [pull_request, issue]) }

      subject.process_with

      expect(subject.pull_requests).to eq [pull_request]
    end
  end

  describe "#issues" do
    let(:project) { build(:project) }
    let(:pull_request) { double("Pull Request", pull_request: true) }
    let(:issue) { double("Issue", pull_request: false) }

    it "returns issue not responds to pull_request" do
      expect(Octokit::Client).to receive(:new) { double(issues: [pull_request, issue]) }

      subject.process_with

      expect(subject.issues).to eq [issue]
    end
  end

  describe "#status" do
    let(:project) { build(:project, ci_type: ci_type) }

    before { expect(Octokit::Client).to receive(:new).and_return(spy) }

    context "travis" do
      let(:ci_type) { "travis" }

      it "returns API result from Status::Travis" do
        expect(Status::Travis).to receive(:new) { double(status: :passed) }

        subject.process_with

        expect(subject.status).to eq :passed
      end
    end

    context "codeship" do
      let(:ci_type) { "codeship" }

      it "returns API result from Status::Codeship" do
        expect(Status::Codeship).to receive(:new) { double(status: :passed) }

        subject.process_with

        expect(subject.status).to eq :passed
      end
    end

    context "Circle CI" do
      let(:ci_type) { "circleci" }

      it "returns API result from Status::Circleci" do
        expect(Status::Circleci).to receive(:new) { double(status: :passed) }

        subject.process_with

        expect(subject.status).to eq :passed
      end
    end

    context "other CIs" do
      let(:ci_type) { "sideci" }

      it "returns :unavailable for other CIs" do
        subject.process_with

        expect(subject.status).to eq :unavailable
      end
    end
  end
end
