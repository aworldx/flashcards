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
    end  
  end
  
  resources :user_sessions

  # post 'set_current_deck(/:deck_id)', to: 'users#set_current_deck', as: 'set_current_deck'

  get 'login', to: 'user_sessions#new', as: 'login'
  post 'logout', to: 'user_sessions#destroy', as: 'logout'
end
