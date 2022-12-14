Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'items/search#find'
      get '/items/find_all', to: 'items/search#find_all'
      get '/merchants/find_all', to: 'merchants/search#find_all'
      get '/merchants/find', to: 'merchants/search#find'
      resources :merchants, only: [:index, :show, :create] do 
        resources :items, controller: :merchant_items, only: [:index]
      end 
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        resources :merchant, controller: :items_merchant, only: [:index]
      end 
    end
  end
end
