Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: :show
      post 'signup', to: 'users#create'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end
end
