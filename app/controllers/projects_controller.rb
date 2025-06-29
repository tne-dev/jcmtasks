class ProjectsController < ApplicationController
  before_action :current_project

  def index
    @pagy, @projects = pagy(current_user.projects.order(:position))
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to project_path(@project), notice: "Project created"
    else
      render :new, alert: "Unable to create project"
    end
  end

  def show
    current_project
    if @tasks
      current_project.tasks
    end
  end

  def edit
    current_project
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project updated"
    else
      render :edit, alert: "Unable to update project"
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_path, notice: "Project #{@project.title} deleted"
  end

  private
  def current_project
    @project = current_user.projects.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :position)
  end
end
