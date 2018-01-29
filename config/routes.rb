Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'

  resources :decks do
    resources :cards do
      post 'check', on: :member, as: 'check_translate'
    end
  end

  # post 'check/:id', to: 'cards#check', as: 'check_translate'

  resources :users, :user_sessions

  post 'set_current_deck/:deck_id', to: 'users#set_current_deck', as: 'set_current_deck'

  get 'login', to: 'user_sessions#new', as: 'login'
  post 'logout', to: 'user_sessions#destroy', as: 'logout'
end
