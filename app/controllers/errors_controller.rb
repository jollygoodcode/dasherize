class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render view, status: status_code
  end

  private

    def view
      status_code
    end

    def status_code
      params[:code] || 500
    end
end
