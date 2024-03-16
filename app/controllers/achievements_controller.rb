class AchievementsController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @achievements = Achievement.all
  end

  def show
  end

  private

  def achievement_params
    params.require(:achievement).permit(:name, :description, :condition)
  end

  def set_achievement
    @achievement = Achievement.find(params[:id])
  end
end
