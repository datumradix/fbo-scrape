class Opportunity < ActiveRecord::Base
	validates :opportunity, uniqueness: true
	def self.search(search)
		if search
			where('opportunity LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	has_many :comments
end
