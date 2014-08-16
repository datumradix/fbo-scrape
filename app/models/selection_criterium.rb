class SelectionCriterium < ActiveRecord::Base
  belongs_to :team
  belongs_to :set_aside_radio
  has_and_belongs_to_many :classification_codes
  has_and_belongs_to_many :set_asides
  has_and_belongs_to_many :procurement_types
  
end
