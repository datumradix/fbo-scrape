class Opportunity < ActiveRecord::Base
	validates :opportunity, uniqueness: true

	has_many :evaluations, :dependent => :destroy
	has_many :teams, :through => :evaluations

	#belongs_to :agency
	belongs_to :solicitation_number
	belongs_to :naics_code
	belongs_to :opportunity_type
end
