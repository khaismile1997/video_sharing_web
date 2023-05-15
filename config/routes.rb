Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: :show
      post 'signup', to: 'users#create'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'

      resources :videos, only: %i(index create) do
        member do
          post 'like', to: 'likes#like'
          post 'dislike', to: 'likes#dislike'
          delete 'unlike', to: 'likes#unlike'
          delete 'undislike', to: 'likes#undislike'
        end
      end
    end
  end
end
