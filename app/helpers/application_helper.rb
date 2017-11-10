module ApplicationHelper
	def events(organisation) 
		@events = organisation.events
		@past_events = @events.where("end_date < ?", Time.now)
		@upcoming_events = @events.where("end_date >", Time.now)
	end
end
