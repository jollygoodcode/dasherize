class ProjectsController < ApplicationController
  load_and_authorize_resource param_method: :model_params

  def index
    @projects = @projects.order(:repo_name)
  end

  def new
  end

  def create
    if @project.save
      redirect_to projects_path, notice: "#{Project.model_name.human} was successfully created.", change: "projects:#{@project.id}"
    else
      render :new
    end
  end

  def show
    @project = ProjectDecorator.new(@project)
    @project.process_with(current_user.oauth_account.oauth_token)

    render change: "project:#{@project.id}"
  end

  def edit
  end

  def update
    if @project.update(model_params)
      redirect_to @project, notice: "#{Project.model_name.human} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "#{Project.model_name.human} was successfully destroyed."
  end

  private

    def model_params
      params.require(:project).permit(:repo_name, :ci_type, :travis_token, :codeship_uuid)
    end
end
