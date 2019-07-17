Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :products, only: [:create]

      resources :users, only: [:create, :update, :show, :destroy]

    end
  end
end
