authorization do
  role :administrator do
    has_permission_on [:opportunities, :users, :team_members, :teams, :selection_criteria], :to => [:manage]
  end
    
  role :team_lead do
    has_permission_on [:opportunities, :users, :team_members], :to => [:read]
    has_permission_on [:users, :teams, :selection_criteria], :to => [:manage]
  end

  role :evaluator do
    has_permission_on [:opportunities, :users, :team_members, :teams], :to => [:read]
    has_permission_on [:users], :to => [:edit, :update]
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
