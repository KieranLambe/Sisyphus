class UserInterestsController < ApplicationController
  before_action :set_user, only: [:destroy]
  before_action :set_user_interest, only: [:destroy]
  # def index
  #   @user_interests = current_user.user_interests.includes(:interest)
  # end

  def new
    @user_interest = UserInterest.new
    @interests = Interest.all
  end

  def create
    @user_interest = UserInterest.new(user_interest_params)
    if @user_interest.save
      redirect_to new_user_user_interest_path
    else
      @interests = Interest.all
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @user_interest = UserInterest.find(params[:id])
    @user_interest.destroy
    redirect_to new_user_user_interest_path, notice: "User interest successfully deleted."
  end

  private

  def user_interest_params
    params.require(:user_interest).permit(:user_id, :interest_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_interest
    @user_interest = @user.user_interests.find(params[:id])
  end

end
