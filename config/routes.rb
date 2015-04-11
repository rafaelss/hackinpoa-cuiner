Rails.application.routes.draw do
  root "home#index"

  scope defaults: { format: :json } do
    resources :users, only: [:create, :show]
  end
end
