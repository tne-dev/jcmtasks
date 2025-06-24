class TasksController < ApplicationController
  before_action :current_task
  include Pagy::Backend

  def index
    @pagy, @tasks = pagy(current_user.tasks.order(created_at: :desc), items: 10)
  end

  def new
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

  private

  def current_task
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :is_done)
  end
end
