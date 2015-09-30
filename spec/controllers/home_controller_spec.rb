require "rails_helper"

RSpec.describe HomeController do
  let(:user) { create(:user, :with_oauth_account) }

  describe "#index" do
    def do_request
      get :index
    end

    context "signed in" do
      before { sign_in(user) }

      it "redirects" do
        do_request

        expect(response).to redirect_to projects_path
      end
    end

    context "not signed in" do
      before { Rails.cache.clear }

      it "cached" do
        stub_ci_requests_for_home_page
        expect(ProjectDecorator).to receive(:new).exactly(3).times.and_call_original

        do_request
        do_request
      end
    end
  end
end
