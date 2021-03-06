Rails.application.routes.draw do
  root "home#index"

  scope defaults: { format: :json } do
    resources :users, only: [:create, :show]
    post "/user/authenticate", to: "users#authenticate", as: :authenticate_user
    post "/user/logout", to: "users#logout", as: :logout_user
    get "/user", to: "current_user#show", as: :current_user
    resources :menus, only: [:index, :create, :show]
    resources :absences, only: [:index, :create]
    get "/search", to: "search#index", as: :search
  end
end
