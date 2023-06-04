Rails.application.routes.draw do
  authenticate :user, lambda { |u| AvoRoutePolicy.new(user: u).view? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount RailsPgExtras::Web::Engine, at: "pg_extras"
  end

  devise_for :users

  root to: "pages#home"

  resources :teams do
    resources :invitations, controller: "teams/invitations"
    resources :memberships, controller: "teams/memberships", only: [:create, :index, :edit, :update, :destroy]
  end
end
