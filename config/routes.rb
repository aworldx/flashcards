Rails.application.routes.draw do
  root to: 'home#index'
  get 'index', to: 'home#index'

  # post 'card_check', to: 'home#card_check'
  # add member route instead separate route
  resources :cards do
    member do
      post 'check'
    end
  end
end
