class Team < ActiveRecord::Base
  has_one :selection_criterium
  #has_many :users
  has_and_belongs_to_many :users

  has_many :evaluations
  has_many :opportunities, :through => :evaluations 

  has_many :search_keywords

  belongs_to :company
end