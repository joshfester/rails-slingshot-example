Rails.application.routes.draw do
  authenticate :user do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"
end
