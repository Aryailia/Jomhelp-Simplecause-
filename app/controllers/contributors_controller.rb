class ContributorsController < ApplicationController

	def new
	end

	def create
		@contributor = contributor.find(current_user.id)
		if @contributor.admin?
			@new_contributor = Contributor.new(user: params[:id], organisation: @contributor.organisation.id, role: 0)
			@new_contributor.save
		end
	end

	private
		def contributor_params
	      	params.require(:organisation).permit(:email, :name, :address, :city, :postcode, :description)
	    end

end
