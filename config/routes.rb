Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'
  resources :cards, only: :index
end
