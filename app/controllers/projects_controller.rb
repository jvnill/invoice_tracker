class ProjectsController < ApplicationController
  before_action :set_user_as_current_user
  before_action :project_params, only: :create

  load_and_authorize_resource through: :user

  before_action :respond_to_js_only, only: [:new, :edit]

  def index
    @projects = @projects.includes(:client)
  end

  def create
    @project.save
  end

  def show
    @invoices = @project.invoices.includes(project: :client).ordered_by_id.page(params[:page])
  end

  def update
    @project.update_attributes(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params[:project] = params.require(:project).permit(:client_id, :name)
  end
end
