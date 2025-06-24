class ProjectsController < ApplicationController
  before_action :current_project
  include Pagy::Backend

  def index
    @pagy, @projects = pagy(current_user.projects.order(created_at: :desc), items: 10)
  end

  def new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to @project, notice: "Project created"
    else
      render :new, alert: "Unable to create project"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project updated"
    else
      render :edit, alert: "Unable to update project"
    end
  end

  def destroy
    if @project.destroy!
      redirect_to projects_path, notice: "Project deleted"
    end
  end

  private
  def current_project
    @project = current_user.projects.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :position)
  end
end
