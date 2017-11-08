Rails.application.routes.draw do

  
  root 'organisations#index'

  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

 
  resources :events

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 #the routes for follow

  #the routes for organisations 
 resources :organisations
 resources :follows

 # get "/organisations/follow/new" => "follows#new"

  post '/organisations/:id/follow' => 'follows#create', as: :organisation_follow
  post '/organisations/:id/unfollow' => 'follows#destroy', as: :organisation_unfollow

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"



end