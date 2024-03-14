class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
    @user_tasks = current_user.user_tasks
    else
    @user_tasks = []
    end
    @tasks = Task.includes(:interests).all.shuffle
    @tasks = Task.page(params[:page]).per(21)

    if params[:query].present?
      pg_search_scope :global_search,
      against: [ :title, :description ],
      associated_against: {
      interests: [ :title]
      },
      using: {
        tsearch: { prefix: true }
      }
    end
  end

  def home
    if current_user
      @user_tasks = current_user.user_tasks
    else
      @user_tasks = []
    end

    @tasks = if params[:query].present?
               Task.global_search(params[:query])
               @tasks = Task.page(params[:page]).per(21)
             else
               Task.includes(:interests).all.shuffle
               @tasks = Task.page(params[:page]).per(21)
             end
  end
end
