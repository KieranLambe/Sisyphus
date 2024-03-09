class UserTasksController < ApplicationController
  before_action :set_user_task, only: [:show, :edit, :update, :destroy]

  def index
    @user_tasks = current_user.user_tasks.includes(:task)
  end

  def show
  end

  def new
    @user_task = UserTask.new
  end

  def create
    @user_task = UserTask.new(user_task_params)

    if @user_task.save
      redirect_to user_tasks_path, notice: 'User task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_task.update(user_task_params)
      redirect_to user_tasks_path, notice: 'User task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_task.destroy
    redirect_to user_tasks_path, notice: 'User task was successfully destroyed.'
  end

  def add_tasks_to_user
    @user = current_user
    @tasks = randomly_selected_tasks

    @tasks.each do |task|
      @user_task = UserTask.new(user: @user, task: task, complete: false)
      @user_task.save
    end

    redirect_to user_tasks_path, notice: 'Random tasks were successfully assigned to the user.'
  end

  private

  def set_user_task
    @user_task = UserTask.find(params[:id])
  end

  def user_task_params
    params.require(:user_task).permit(:user_id, :task_id, :complete)
  end

  def randomly_selected_tasks
    interests = @user.interests.pluck(:id)
    interest_tasks = Task.where(interest_id: interests).sample(3)
    non_interest_tasks = Task.where.not(interest_id: interests).sample(2)
    tasks = interest_tasks + non_interest_tasks
  end
end
