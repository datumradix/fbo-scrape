class Evaluation < ActiveRecord::Base
  has_many :comments

  belongs_to :evaluation_code
  belongs_to :opportunity 
  belongs_to :team

end
