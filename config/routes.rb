Rails.application.routes.draw do
  root "home#index"

  scope defaults: { format: :json } do
    resources :users, only: [:create]
    resource :user, only: [:show] do
      member do
        post :authenticate
      end
    end
  end
end
