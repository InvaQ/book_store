Rails.application.routes.draw do    

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
    
    
  scope "(:locale)", locale: /en|ru/ do  
    resources :orders
    resources :carts, only: [:show, :update]
    resources :line_items
    resources :catalog, only: [:index, :show]
    resources :checkouts, only: [:show, :update]
    resources :books do
      post :create_line_item, on: :member
    end
    resource :user, only: [:edit] do 
      collection do 
        patch 'update_password'
        patch 'update_email'
      end
    end
    get '/users/:id', to: 'users#settings', as: 'settings'
    patch 'users/:id', to: 'users#update_address', as:'update_address'
    root to:"home#index"
  end


end
