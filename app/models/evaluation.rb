class Evaluation < ActiveRecord::Base
  belongs_to :evaluation_code
  belongs_to :opportunity 
  belongs_to :team

end
