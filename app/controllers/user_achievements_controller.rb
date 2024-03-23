class UserAchievementsController < ApplicationController
  def index
    @user_achievements = UserAchievement.all
  end

  def new
    @user_achievement = UserAchievement.new
  end

  def create
    @user_achievement = UserAchievement.new(user_achievement_params)
    @user_achievement.save!
    redirect_to root_path
  end

  def update
    @user_achievement = UserAchievement.find(params[:id])
    @user_achievement.update(achieved: true)
  end

  def add_user_achievement
    @user_achievement = UserAchievemnet.new(user_achievement_params)
    @user_achievement.save!
  end

  private

  def user_achievement_params
    params.require(:user_achievement).permit(:user_id, :interest_id)
  end
end
