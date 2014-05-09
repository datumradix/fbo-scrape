authorization do
  role :admin do
    has_permission_on [:opportunities], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:users, :user_sessions], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
    has_permission_on :opportunities, :to => [:index]
    has_permission_on :users, :to => [:index]
    has_permission_on :user_sessions, :to => [:new, :create, :index]
  end
  
  role :user do
    #includes :guest
    has_permission_on :opportunities, :to => [:index, :show]
  end
  
  role :manager do
    #includes :user
    has_permission_on [:opportunities], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :comments, :to => [:new, :create, :show] 
  end
end