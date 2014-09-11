class Team < ActiveRecord::Base
  has_one :selection_criterium
  has_many :users
  has_many :evaluations
  has_many :opportunities, :through => :evaluations 
  belongs_to :company
end