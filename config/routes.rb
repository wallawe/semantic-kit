WrapSemantic::Application.routes.draw do
  get 'tags/show'

  get 'dashboards/show'

  root "info#home"

  get "/help",   to: "info#help", as: "help"

  get "/logout", to: "sessions#destroy", as: "logout"

  get "/signin", to: "sessions#new",     as: "signin"

  resource  :account,       only: [:show]
  resources :categories
  resource  :dashboard,     only: [:show]

  resources :previews,      only: [:show]
  resources :sessions,      only: [:new, :create]
  resources :subscriptions, only: [:create]

  resources :tags,          only: [:show]
  resources :themes
  resources :users,         only: [:new, :create, :show]

  namespace :admin do
    resource :dashboard,    only: [:show]
  end
end
