Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  namespace :v1 do
    post :signup, to: "auth#signup"
    post :login, to: "auth#login"
    post :logout, to: "auth#logout"

    namespace :my do
      resources :houses
      get "/details", to: "details#index"
      put "/details", to: "details#update"
      put "/password", to: "password#update"
    end
    resources :houses
    resources :messages do
      get "/exchanged_users", to: "messages#exchanged_users", on: :collection
      post "/anonymous_create", to: "messages#anonymous_create", on: :collection
    end
  end
end
