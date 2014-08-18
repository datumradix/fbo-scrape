class Team < ActiveRecord::Base
  has_one :selection_criterium
  has_many :users
  #has_and_belongs_to_many :opportunities

  #attr_accessible :name, :opportunity
  has_many :evaluations
  has_many :opportunities, :through => :evaluations 
end


#teams.opportunities