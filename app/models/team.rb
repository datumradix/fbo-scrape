class Team < ActiveRecord::Base
  has_one :selection_criterium
  has_many :users
  #has_many :classification_codes, :through => :selection_criterium
  has_and_belongs_to_many :opportunities
end
