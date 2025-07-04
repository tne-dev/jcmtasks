class TasksController < ApplicationController
  before_action :current_task
  before_action :user_collections

  def index
    tasks = current_user.tasks.includes(:project, :tags).order(created_at: :desc)
    if params[:project_id].present?
      project = @projects.find_by(id: params[:project_id])
      tasks = project ? tasks.filter_per_project(project) : tasks
    end
    if params[:is_done].present?
      desired = ActiveModel::Type::Boolean.new.cast(params[:is_done])
      tasks = tasks.filter_per_status(desired)
    end
    if params[:tag_ids].present?
      tag_ids = Array(params[:tag_ids]).reject(&:blank?)
      tasks = tasks.filter_per_tags(tag_ids) if tag_ids.any?
    end
    @pagy, @tasks = pagy(tasks)
  end

  def new
    @task = current_user.tasks.new
    @projects.order(:position)
    @tags
  end

  def create
    # @project = current_user.projects.find_by(id: params[:id])
    @task = current_user.tasks.create(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "Task created"
    else
      render :new, alert: "Unable to create task"
    end
  end
  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Task updated"
    else
      render :edit, alert: "Unable to update task"
    end
  end

  def update_completion_status
    @task.toggle!(:is_done)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to task_path(@task), notice: "Task set to toggled to #{@task.status?}." }
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "Task #{@task.title} deleted successfully"
  end

  private

  def current_task
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def user_collections
    @projects = current_user.projects
    @tags = current_user.tags
  end

  def task_params
    params.require(:task).permit(:title, :description, :is_done, :project_id, tag_ids: [])
  end
end
