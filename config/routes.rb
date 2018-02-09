require 'sidekiq/web'

Rails.application.routes.draw do 
  root to: 'home#index'
  get 'index', to: 'home#index'

  resources :decks do
    resources :cards, shallow: true do
      member do
        post 'check_translate'
      end
    end
  end

  resources :users do
    member do
      post 'set_current_deck(/:deck_id)', action: 'set_current_deck', as: 'set_current_deck'
      post 'remove_current_deck', action: 'remove_current_deck', as: 'remove_current_deck'
    end
  end

  resources :user_sessions

  get 'login', to: 'user_sessions#new', as: 'login'
  post 'logout', to: 'user_sessions#destroy', as: 'logout'

  mount Sidekiq::Web => '/sidekiq'
end
