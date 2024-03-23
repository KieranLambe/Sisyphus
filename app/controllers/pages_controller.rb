class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      @user_tasks = current_user.user_tasks.to_a
      @user_achievements = current_user.user_achievements.to_a
    else
      @user_tasks = []
      @user_achievements = []
    end

    # @tasks = if params[:query].present?
    #            Task.where("title ILIKE ?", "%#{params[:query]}%")
    #          else
    #            Task.includes(:interests).all.shuffle
    #          end

    @tasks = Task.page(params[:page]).per(21)

    respond_to do |format|
      format.html
      format.text { render partial: 'pages/lists', locals: { tasks: @tasks }, formats: [:html]}
    end


    @interests = Interest.all
    @achievements = Achievement.all
  end
end
