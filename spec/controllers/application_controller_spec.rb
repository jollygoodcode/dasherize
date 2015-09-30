require "rails_helper"

RSpec.describe ApplicationController do
  controller do
    skip_before_action :authenticate_user!

    def index
      raise CanCan::AccessDenied
    end
  end

  describe "respond_to_access_denied" do
    let(:referer) { "http://test.host/?123=456" }

    before { request.env["HTTP_REFERER"] = referer }

    describe "GET" do
      it "respond forbidden for xhr" do
        xhr :get, :index
        expect(response.status).to eq(401)
      end

      it "redirects to root_path when signed in" do
        sign_in create(:user)
        get :index
        expect(response).to redirect_to(root_path)
      end

      it "redirects to new_user_session_path when not signed in" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it "stores request.url as session[user_return_to]" do
        expect {
          get :index, abc: 123
        }.to change {
          session["user_return_to"]
        }.to eq("http://test.host/anonymous?abc=123")
      end

      it "stores param[user_return_to] as session[user_return_to]" do
        expect {
          get :index, abc: 123, user_return_to: root_path(hello: "world")
        }.to change {
          session["user_return_to"]
        }.to eq(root_path(hello: "world"))
      end
    end

    describe "POST" do
      it "respond forbidden for xhr" do
        xhr :post, :index
        expect(response.status).to eq(401)
      end

      it "redirects to new_user_session_path" do
        post :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it "stores request.referer as session[user_return_to]" do
        expect {
          post :index, abc: 123
        }.to change {
          session["user_return_to"]
        }.to eq(referer)
      end

      it "stores param[user_return_to] as session[user_return_to]" do
        expect {
          post :index, abc: 123, user_return_to: root_path(hello: "world")
        }.to change {
          session["user_return_to"]
        }.to eq(root_path(hello: "world"))
      end
    end
  end
end
