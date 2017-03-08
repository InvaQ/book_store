Rails.application.routes.draw do

  root to:"home#index"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  get '/users/:id', to: 'users#settings', as: 'settings'
  patch 'users/:id', to: 'users#update_address', as:'update_address'
  resource :user, only: [:edit] do 
    collection do 
      patch 'update_password'
      patch 'update_email'
    end
  end
  
  
  resources :catalog, only: [:index, :show]
  resources :checkouts, only: [:show, :update]
  resources :books
  resources :orders
  resources :carts
  resources :line_items




end
