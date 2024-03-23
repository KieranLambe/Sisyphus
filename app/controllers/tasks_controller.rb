class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @interests = Interest.all

    @tasks = if params[:query].present?
                Task.includes(:interests).joins(:interests).
                where("tasks.title ILIKE ? OR tasks.description ILIKE ? OR interests.title ILIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%","%#{params[:query]}%")
                .order(Arel.sql('RANDOM()')).page(params[:page]).per(21)
              else
                Task.includes(:interests).all.order(:title).page(params[:page]).per(21)
              .where("tasks.title ILIKE ? OR tasks.description ILIKE ? OR interests.title ILIKE ? ",
                          "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
             else
               Task.includes(:interests).all.shuffle

             end


    respond_to do |format|
      format.html
      format.text { render partial: 'tasks/lists', locals: { tasks: @tasks }, formats: [:html]}
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, status: :see_other, notice: "Task deleted"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
