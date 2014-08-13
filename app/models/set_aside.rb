class SetAside < ActiveRecord::Base
  has_and_belongs_to_many :selection_criteria
  
end
