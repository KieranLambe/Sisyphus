class AchievementsController < ApplicationController
  before_action :set_task, only: [:show]

  def index
    @achievements = Achievement.all
    if current_user
      @user_achievements = current_user.user_achievements.to_a
    else
      @user_achievements = []
    end
  end

  def show
  end

  def new
    @achievement = Achievement.new
  end

  private

  def achievement_params
    params.require(:achievement).permit(:name, :description, :condition)
  end

  def set_achievement
    @achievement = Achievement.find(params[:id])
  end
end
