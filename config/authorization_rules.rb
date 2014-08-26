
#Guest and administrator roles work fine.  I assume these are default roles that declarative authorization.
#team_lead translates to a strange symbol. it ignores the "_" and keeps capitalization.
#i will set the roles under administrator, and then paste into other roles when they are active.

authorization do
  role :administrator do
    has_permission_on [:opportunities, :users, :team_members, :teams, :selection_criteria], :to => [:manage]
  end
    
  role :team_lead do
    #has_permission_on [:opportunities, :users, :team_members], :to => [:read]
    #has_permission_on [:users, :teams], :to => [:edit, :update]
  end

  role :evaluator do
    #has_permission_on [:opportunities, :users, :team_members, :teams], :to => [:read]
    #has_permission_on [:users], :to => [:edit, :update]
    has_permission_on :opportunities, :to => [:index]
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
