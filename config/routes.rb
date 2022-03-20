Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post :signup, to: "auth#signup"
  post :login, to: "auth#login"
  post :logout, to: "auth#logout"
end
