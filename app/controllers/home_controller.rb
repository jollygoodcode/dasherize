class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_to_dashboard, if: :user_signed_in?

  def index
    @projects =
      Rails.cache.fetch("home-index", expires_in: 24.hours) do
        _projects =
          [
            Project.new(repo_name: "sinatra/sinatra", ci_type: :travis),
            Project.new(repo_name: "jollygoodcode/twemoji", ci_type: :travis),
            Project.new(repo_name: "winston/google_visualr", ci_type: :travis)
          ]
        _projects.map! { |project| ProjectDecorator.new(project) }
        _projects.each(&:process_with)
        _projects
      end
  end

  private

    def redirect_to_dashboard
      redirect_to projects_path
    end
end
