WrapSemantic::Application.routes.draw do
  root "info#home"

  get "/signin", to: "sessions#new", as: "signin"

  resources :previews, only: [:show]
  resources :sessions, only: [:new, :create]
  resources :themes
  resources :users,    only: [:new, :create, :show]
end
