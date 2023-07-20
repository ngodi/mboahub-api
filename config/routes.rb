Rails.application.routes.draw do
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
    end
  end
end
