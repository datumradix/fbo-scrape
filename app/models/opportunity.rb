class Opportunity < ActiveRecord::Base
	searchable do 
		text :opportunity, :agency, :class_code, :opp_type
		time :post_date
	end
end
