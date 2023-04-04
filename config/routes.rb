Rails.application.routes.draw do
  resources :teams
  authenticate :user, lambda { |u| AvoRoutePolicy.new(user: u).view? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount RailsPgExtras::Web::Engine, at: "pg_extras"
  end

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"
end
