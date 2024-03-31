class UserTasksController < ApplicationController
  before_action :set_user_task, only: %i[show edit update destroy]

  def index
    @user_tasks = current_user.user_tasks.includes(:task)
  end

  def show
    # @user = User.find(params[:id])
    # @user_task.user = current_user
  end

  def new
    @user_task = UserTask.new
  end

  def create
    @user_task = UserTask.new(user_task_params)
    if @user_task.save
      redirect_to root_path, notice: 'User task was successfully created.'
    else
      raise
    end
  end

  def edit
  end

  def update
    @user_task = current_user.user_tasks.find(params[:id])
    if @user_task.update(user_task_complete_params)
      render json: { message: "#{@user_task}" }
    else
      render json: { error: @user_task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # render json: { message: "Task has been removed" }
    if @user_task.destroy
      respond_to :json
    end
    # render json: { error: @user_task.errors.full_messages }, status: :unprocessable_entity
  end

  def add_tasks_to_user
    @user = current_user
    @user_tasks = random_tasks
    success = true

    @user_tasks.each do |task|
      user_task = UserTask.create(user_id: @user.id, task_id: task.id)
      unless user_task.save
        success = false
        break
      end
    end

    if success
      redirect_to root_path, notice: 'Random tasks were successfully assigned to the user.'
    else
      redirect_to root_path, alert: 'Failed to assign random tasks to the user.'
    end
  end

  def add_task
    @user_task = UserTask.new(user_task_params)
    if @user_task.save!
      redirect_to root_path, notice: 'Task added'
    else
      redirect_to root_path, notice: "Task limit reached"
    end
  end

  def toggle_complete
    @user_task = UserTask.find(params[:id])
    @user_task.update user_task_complete_params
    @user_task.save
    redirect_to root_path, notice: 'Task complete'
  end

  private

  def set_user_task
    @user_task = UserTask.find(params[:id])
  end

  def user_task_params
    params.permit(:user_id, :task_id)
  end

  def user_task_complete_params
    params.require(:user_task).permit(:complete)
  end


  def random_tasks
    user = current_user.id
    user_interests = UserInterest.where(user_id: user).pluck(:interest_id)

    interest_tasks = Task.joins(:interests).where(interests: {id: user_interests}).sample(3)
    non_interest_tasks = Task.joins(:interests).where.not(interests: {id: user_interests}).sample(1)

    interest_tasks + non_interest_tasks
  end
end
