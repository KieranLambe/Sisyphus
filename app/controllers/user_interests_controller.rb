class UserInterestsController < ApplicationController
  # def index
  #   @user_interests = current_user.user_interests.includes(:interest)
  # end

  def new
    @user_interest = UserInterest.new
  end

  def create
    @user_interest = UserInterest.new(user_interest_params)
    if @user_interest.save!
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_interest_params
    params.require(:user_interest).permit(:user_id, :interest_id)
  end
end
