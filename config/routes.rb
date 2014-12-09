WrapSemantic::Application.routes.draw do
  root "info#home"

  get "/sell-semantic-ui-themes", to: "info#sell", as: "sell"
  get "/logout",                  to: "sessions#destroy", as: "logout"
  get "/signin",                  to: "sessions#new",     as: "signin"
  get "/privacy-policy",          to: "info#privacy_policy"
  get "/terms",                   to: "info#terms"
  get "/faq",                     to: "info#faq"
  get "/about",                   to: "info#about"

  ["semantic-ui-themes", "semantic-ui-snippets"].each do |slug|
    controller = slug.gsub("semantic-ui-", "")
    get "/#{slug}", to: "#{controller}#index"
  end

  resource  :account,             only: [:show]
  resources :categories
  resource  :dashboard,           only: [:show]
  resources :expos,               except: [:show]

  resources :favorites,           only: [:create, :destroy]

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
  resources :themes do
    member do
      get 'preview'
    end
  end

  resources :theme_approvals,     only: [:update, :destroy]
  resources :expo_approvals,      only: [:update, :destroy]
  resources :users

  namespace :admin do
    resource :dashboard,          only: [:show]
  end
end
