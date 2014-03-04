class Opportunity < ActiveRecord::Base
	validates :opportunity, uniqueness: true
	#searchable do 
	#	text :opportunity, :agency, :class_code, :opp_type
	#	time :post_date
	#end
	def self.search(search)
		if search
			where('opportunity LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
end
