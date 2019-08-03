require "resque/server"

Rails.application.routes.draw do
  devise_for :users, only: :sessions, controllers: {
    sessions: "sessions"
  }

  mount Resque::Server, at: "/jobs"

  namespace :api do
    namespace :v1 do
      resources :downloads do
        member do
          put :cancel
          put :queue
        end
        collection do
          post :clear
        end
      end
    end
  end
end
