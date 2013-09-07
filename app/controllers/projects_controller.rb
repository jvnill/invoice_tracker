class ProjectsController < ApplicationController
  before_filter :fetch_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects.includes(:client)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
  end

  def show
    @invoices = @project.invoices
  end

  def update
    @project.update_attributes(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:client_id, :name)
  end

  def fetch_project
    @project = Project
      .includes(:client)
      .where(clients: { user_id: current_user.id })
      .find(params[:id])
  end
end
