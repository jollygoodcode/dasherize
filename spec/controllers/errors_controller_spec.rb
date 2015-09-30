require "rails_helper"

RSpec.describe ErrorsController do
  describe "#show" do
    def do_request
      get :show, params
    end

    context "404" do
      let(:params) { Hash(code: 404) }

      it "renders and status" do
        do_request

        expect(response).to render_template("404")
        expect(response).to have_http_status(404)
      end
    end

    context "422" do
      let(:params) { Hash(code: 422) }

      it "renders and status" do
        do_request

        expect(response).to render_template("422")
        expect(response).to have_http_status(422)
      end
    end

    context "500" do
      let(:params) { Hash(code: 500) }

      it "renders and status" do
        do_request

        expect(response).to render_template("500")
        expect(response).to have_http_status(500)
      end
    end
  end
end
