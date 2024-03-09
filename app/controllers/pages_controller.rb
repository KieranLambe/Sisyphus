class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user_tasks = current_user.user_tasks
  end
end
