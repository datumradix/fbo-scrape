class Evaluation < ActiveRecord::Base
  has_many :comments
  accepts_nested_attributes_for :comments

  belongs_to :evaluation_code
  belongs_to :opportunity 
  belongs_to :team

end
