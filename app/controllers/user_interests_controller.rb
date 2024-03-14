class UserInterestsController < ApplicationController
  # def index
  #   @user_interests = current_user.user_interests.includes(:interest)
  # end

  def new
    @interests = Interest.all
    @user_interest = UserInterest.new
    # @user_interest.interest = @interests[0]
  end

  def create
    @user_interest = UserInterest.new(user_interest_params)
    @user_interest.user = current_user
    @user_interest.interest = @interest
    if @user_interest.save!
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def updated
  end

  private

  def user_interest_params
    params.require(:user_interest).permit(:user_id, :interest_id)
  end
end
