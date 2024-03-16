class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]



  def home
    if current_user
      @user_tasks = current_user.user_tasks
    else
      @user_tasks = []
    end

    @tasks = if params[:query].present?
               Task.where("title ILIKE ?", "%#{params[:query]}%")
             else
               Task.includes(:interests).all.shuffle
             end


    @tasks = Task.page(params[:page]).per(21)
  end

end
