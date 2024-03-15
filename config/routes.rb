Rails.application.routes.draw do
  devise_for :views
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # resources :registration do
  #   collection do
  #     get :interests
  #   end
  # end

  resources :users do
    resources :user_interests, except: %i[show]
    resources :user_tasks do
      post :add_task_to_user
    end
  end

  resources :tasks do
    resources :interest_tasks, only: %i[new create]
    # resources :user_tasks, except: %i[]
  end

  # resources :interests, only: %i[index]
  # resources :user_interests
  # resources :interest_task
  # end

  resources :user_tasks do
    member do
      patch 'toggle_complete'
    end
  end
  
end
