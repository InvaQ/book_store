Rails.application.routes.draw do

  devise_for :users
  root to:"home#home"
  
  resources :catalog, only: [:index, :show]

  resources :books
  resources :orders
  resources :carts
  resources :line_items



end
