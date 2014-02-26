module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
		link_to title, :sort => column, :direction => direction
	end
end

def increment(opportunity)
	opportunity.like += 1
	opportunity.save
end

def decrement(opportunity)
	opportunity.like -= 1
	opportunity.save
end
