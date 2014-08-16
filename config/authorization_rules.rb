authorization do
  role :administrator do
    has_permission_on [:opportunities, :teams, :users, :roles, :selection_criteria], :to => [:manage]
  end
    
  role :team_lead do
    has_permission_on [:opportunities, :teams], :to => [:read, :update]
  end

  role :evaluator do
    has_permission_on [:opportunities, :teams, :users, :user_sessions], :to => [:read]
    has_permission_on [:selection_criteria], :to => [:read]
  end

  role :guest do 
    has_permission_on :opportunities, :to => [:index]
  end
end

privileges do 
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => :new 
  privilege :read,   :includes => [:index, :show]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy 
end