class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
    @user_tasks = current_user.user_tasks
    else
    @user_tasks = []
    end
  end
end
