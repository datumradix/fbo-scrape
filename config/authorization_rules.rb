authorization do
  role :administrator do
    has_permission_on [:opportunities, :teams, :users, :roles, :selection_criteria], :to => [:manage]
  end
    
  role :team_lead do
    has_permission_on [:opportunities, :teams], :to => [:read, :update]
  end

  # user.title

  role :Evaluator do
    #has_permission_on [:opportunities, :teams, :users, :user_sessions], :to => [:read]
    #has_permission_on :selection_criteria, :to => :read
    # has_permission_on :opportunities, :to => [:index]
    has_permission_on :opportunities do
      to :index

      if_attribute :role_id => is { raise }
    end
  end

  role :guest do 
    #has_permission_on :opportunities, :to => [:index]
  end
end

privileges do 
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => :new 
  privilege :read,   :includes => [:index, :show]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy 
end
