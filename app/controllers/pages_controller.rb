class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      @user_tasks = current_user.user_tasks.to_a
    else
      @user_tasks = []
    end

    # @tasks = if params[:query].present?
    #            Task.where("title ILIKE ?", "%#{params[:query]}%")
    #          else
    #            Task.includes(:interests).all.shuffle
    #          end
  end
end
