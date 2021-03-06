Fbo::Application.routes.draw do
  
  resources :opportunity_types

  resources :naics_codes

  resources :solicitation_numbers

  resources :agencies

  resources :search_keywords

  resources :team_members

  resources :companies

  resources :evaluation_codes

  resources :evaluations

  resources :set_aside_radios

  resources :teams 

  resources :selection_criteria

  resources :classification_codes

  resources :set_asides

  resources :procurement_types

  resources :roles

  resources :management_evaluations

  resources :team_members, only: [:index]

  resources :manage_teams

  #match '/new_user' to "login", :controller => "user_sessions", :action => "new"
  #login "logout", :controller => "user_sessions", :action => "destroy"

  resources :user_sessions 

  get 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users do 
    get 'team_index', :on => :collection
    resources :team_members, only: [:index]
  end

  resources :comments

  get "static_pages/private_team"

  get "static_pages/help"

  get "static_pages/about"

  get "public_teams/public_team_criteria"

  get "public_teams/public_team_members"

  get "public_teams/opportunities"

  resources :opportunities do
    #member do
    #  get 'increment'
    #  get 'decrement'
    #end
    collection do
      match 'search' => 'opportunities#search', via: [:get, :post], as: :search  
    end
    #collection { post :search, to: 'opportunities#index' }
  end

  resources :opportunity do
    member do
      get 'increment'
      get 'decrement'
      get 'manager'
    end
  end

  resources :plain_views do
    member do
    end
  end

  #map.resources :password_resets, :only => [ :new, :create, :edit, :update ]
  resources :password_resets #, :only => [ :new, :create, :edit, :update ]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#about'
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/help',   to: 'static_pages#help',   via: 'get'
  match '/private_team',   to: 'static_pages#private_team',   via: 'get'
  match '/team_members', to: 'users#team_index', via: 'get'

  match '/public_team_criteria', to: 'public_teams#criteria', via: 'get'
  match '/public_team_members', to: 'public_teams#users', via: 'get'
  match '/public_team_opportunities', to: 'public_teams#opportunities', via: 'get'
  match '/reports', to: 'plain_views#index', via: 'get'


  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
