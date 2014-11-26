WrapSemantic::Application.routes.draw do
  root "info#home"

  get "/help",   to: "info#help", as: "help"
  get "/sell-semantic-ui-themes",   to: "info#sell", as: "sell"
  get "/logout", to: "sessions#destroy", as: "logout"
  get "/signin", to: "sessions#new",     as: "signin"

  ["semantic-ui-themes", "semantic-ui-snippets"].each do |slug|
    controller = slug.gsub("semantic-ui-", "")
    get "/#{slug}", to: "#{controller}#index"
  end

  resource  :account,             only: [:show]
  resources :categories
  resource  :dashboard,           only: [:show]

  resources :payment_preferences, only: [:new, :create]
  resources :previews,            only: [:show]
  resources :sessions,            only: [:new, :create]
  resources :snippets do
    member do
      get 'iframe_content'
    end
  end
  resources :subscriptions,       only: [:create]

  resources :tags,                only: [:show]
  resources :themes
  resources :theme_approvals,     only: [:update, :destroy]
  resources :users,               only: [:new, :create, :show, :edit, :update, :index]

  namespace :admin do
    resource :dashboard,          only: [:show]
  end
end
