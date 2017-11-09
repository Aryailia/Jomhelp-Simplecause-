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
    resources :contributors
    resources :posts, only: [:create, :new]
    post 'follow' => 'follows#create'
    post 'unfollow' => 'follows#destroy'
  end
  #routes for contributors
  resources :events
  
  # User actions with organisations
  resources :follows
  resources :posts
end 