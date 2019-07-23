Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :products, only: [:create, :show, :destroy]
      resources :users, only: [:create, :update, :show, :destroy] do
        resources :pets, only: [:index, :show, :create, :update, :destroy] do
          get '/products', to: 'products#pet_products_index'
          get '/products/:id', to: 'pet_products#show'
          post '/products/:id', to: 'pet_products#create'
          patch '/products/:id', to: 'pet_products#update'
        end
        get '/products', to: 'products#index'
      end
    end
  end
end
