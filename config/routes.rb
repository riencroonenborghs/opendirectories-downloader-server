require 'resque/server'

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'
  mount Resque::Server.new, at: "/resque"
  namespace :api do
    namespace :v1 do
      resources :downloads do
        member do
          put :cancel
          put :queue
        end
        collection do
          post :clear
          post :reorder
        end
      end
    end
  end
end
