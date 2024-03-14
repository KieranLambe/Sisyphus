class UsersController < ApplicationController
  before_action :set_user, only: %i[update]

  def show
  end

  def update
    @user.update(user_params)
    @user.save!
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(interest_ids: [])
  end
end
