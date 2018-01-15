Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'

  resources :cards do
    member do
      post 'check'
    end
  end

  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
