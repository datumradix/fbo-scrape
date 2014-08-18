class Opportunity < ActiveRecord::Base
	validates :opportunity, uniqueness: true
	def self.search(search)
		if search
			where('opportunity || opportunity_description || agency || opp_type || class_code LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	#has_and_belongs_to_many :teams
	has_many :comments, :dependent => :destroy
	accepts_nested_attributes_for :comments


	has_many :evaluations
	has_many :teams, :through => :evaluations
end
