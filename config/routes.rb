require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home/home#index'
  get 'index', to: 'home/home#index'

  scope module: 'dashboard' do
    resources :decks do
      resources :cards, shallow: true do
        member do
          post 'check_translate'
        end
      end
    end
  end

  scope module: 'home' do
    resources :users do
      member do
        post 'set_current_deck(/:deck_id)', action: 'set_current_deck', as: 'set_current_deck'
        post 'remove_current_deck', action: 'remove_current_deck', as: 'remove_current_deck'
      end
    end

    resources :user_sessions
  end

  get 'login', to: 'home/user_sessions#new', as: 'login'
  post 'logout', to: 'home/user_sessions#destroy', as: 'logout'

  mount Sidekiq::Web => '/sidekiq'
end
