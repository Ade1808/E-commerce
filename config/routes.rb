Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :order_items ,except:[:edit,:index,:show,:new]
  resources :orders do
    member do 
     get :add_order_items  
    end
  end
  resources :cart_items do
  member do 
      get :destroy_cart_items
    end
  end
  resources :carts 
  resources :options
  resources :categories
  resources :products
  resources :charges
  devise_for :users 
  get 'products/index'
  root 'products#index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
