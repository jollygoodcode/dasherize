require "rails_helper"

RSpec.describe ProjectsController do
  let(:user) { create(:user, :with_oauth_account) }

  before { sign_in user }

  describe '#index' do
    def do_request
      get :index
    end

    before { do_request }

    it { expect(response).to be_success }
  end

  describe '#new' do
    def do_request
      get :new
    end

    before { do_request }

    it { expect(assigns[:project]).to be_instance_of(Project) }
    it { expect(response).to be_success }
  end

  describe '#create' do
    def do_request
      post :create, project: params
    end

    context "success" do
      let(:params) { attributes_for(:project) }

      it "creates new project" do
        expect { do_request }.to change(Project, :count).by(1)

        project = Project.last
        expect(project.user).to eq user
        params.each_pair do |attr, value|
          expect(project.send(attr)).to eq value
        end
      end

      it "redirects" do
        do_request
        expect(response).to redirect_to projects_path
      end
    end

    context "failure" do
      let(:params) { Hash(repo_name: nil) }

      it "does not create project" do
        expect { do_request }.not_to change(Project, :count)
      end

      it "renders new" do
        do_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    let(:project) { create(:project, user: user) }

    def do_request
      get :show, id: project.id
    end

    before do
      allow_any_instance_of(ProjectDecorator).to receive(:call_apis)
      do_request
    end

    it { expect(assigns(:project)).to eq project }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    let(:project) { create(:project, user: user) }

    def do_request
      get :edit, id: project.id
    end

    before { do_request }

    it { expect(assigns(:project)).to eq project }
    it { expect(response).to be_success }
  end

  describe '#update' do
    let(:project) { create(:project, user: user) }

    def do_request
      patch :update, id: project.id, project: params
    end

    before { do_request }

    context "success" do
      let(:params) { Hash(id: project.id, repo_name: project.repo_name + "-modified") }

      before { do_request }

      it { expect(assigns(:project).repo_name).to match "-modified" }
      it { expect(response).to redirect_to project_path(assigns(:project)) }
    end

    context "failure" do
      let(:params) { Hash(repo_name: "") }

      it { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:project) { create(:project, user: user) }

    def do_request
      delete :destroy, id: project.id
    end

    it "deletes a project" do
      expect { do_request }.to change(Project, :count).by(-1)
    end

    it "redirects" do
      do_request
      expect(response).to redirect_to projects_path
    end
  end
end
