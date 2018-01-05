Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'
  resources :cards
  post 'card_check', to: 'home#card_check'
end
