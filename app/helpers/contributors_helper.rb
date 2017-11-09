module ContributorsHelper

	def contributor?(organisation)
		@organisation = Organisation.find(organisation.id)
		@contributors = @organisation.contributors.where(:approval_request => true)
		@contributor = @contributors.find_by(user_id: current_user.id)
		if @contributor.nil?
			return false
		else
			return true
		end
	end
	
end
