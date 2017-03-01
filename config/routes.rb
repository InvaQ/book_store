Rails.application.routes.draw do

  devise_for :users
  get '/users/:id', to: 'users#settings', as: 'settings'
  patch '/users/:id', to: 'users#update_address', as:'update_address'
  root to:"home#index"
  
  resources :catalog, only: [:index, :show]

  resources :books
  resources :orders
  resources :carts
  resources :line_items




end
