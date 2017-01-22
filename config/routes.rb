Rails.application.routes.draw do

  root to:"home#home"
  
  get 'catalog/index'


  resources :books
  resources :orders
  resources :carts
  resources :line_items



end
