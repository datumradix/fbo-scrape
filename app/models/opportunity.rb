class Opportunity < ActiveRecord::Base
	validates :opportunity, uniqueness: true
	def self.search(search)
		if search
			where('opportunity || opportunity_description || agency || opp_type || class_code LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	
	has_many :comments, :dependent => :destroy
	accepts_nested_attributes_for :comments
end
