Fbo::Application.routes.draw do
  
  resources :management_evaluations

  #match '/new_user' to "login", :controller => "user_sessions", :action => "new"
  #login "logout", :controller => "user_sessions", :action => "destroy"

  resources :user_sessions 

  get 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users

  resources :comments

  get "static_pages/criteria"

  get "static_pages/about"
  resources :opportunities do
    member do
      get 'increment'
      get 'decrement'
    end
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


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'opportunities#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/criteria',   to: 'statuc_pages#criteria',   via: 'get'


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
