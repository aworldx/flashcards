Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'

  resources :decks do
    resources :cards
  end

  post 'check/:id', to: 'cards#check', as: 'check_translate'

  resources :users, :user_sessions

  get 'login', to: 'user_sessions#new', as: 'login'
  post 'logout', to: 'user_sessions#destroy', as: 'logout'
end
