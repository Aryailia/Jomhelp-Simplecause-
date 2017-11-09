Rails.application.routes.draw do  
  root 'organisations#index'

  # For sessions
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
  
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  #the routes for organisations 
  resources :organisations do 
    resources :contributors, only: [:create, :destroy, :index]
  end

  get "/organisations/:id/admin_dashboard" => "organisations#admin_dashboard", as: :admin_dashboard 

  get "/organisations/:organisation_id/unapproved_contributors" => "contributors#unapproved_contributors", as: :unapproved_contributors

  post "/organisations/:organisation_id/approve_contributor/:id" => "contributors#approve_contributor", as: :approve_contributor

  delete "/uncontribute/:id" => "contributors#uncontribute", as: :uncontribute

  #routes for events
  resources :events
  
  # User actions with organisations
  resources :follows
  get 'relationships/follow_user'  
  get 'relationships/unfollow_user'
  # get "/organisations/follow/new" => "follows#new"
  post '/organisations/:id/follow' => 'follows#create', as: :organisation_follow
  post '/organisations/:id/unfollow' => 'follows#destroy', as: :organisation_unfollow
end
