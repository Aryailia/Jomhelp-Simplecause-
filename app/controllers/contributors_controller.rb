class ContributorsController < ApplicationController
	before_action :check_contributor
	before_action :check_admin, only: [ :create, :destroy, :upgrade ]

	def index
	end

	def new
	end

	def create
		@new_contributor = Contributor.new(user: params[:id], organisation: @contributor.organisation.id, role: 0)
		@new_contributor.save
	end

	def destroy
		@contributor.destroy
	end

	def upgrade

	end

	private

	def contributor_params
  	params.require(:organisation).permit(:email, :name, :address, :city, :postcode, :description)
  end

  def check_contributor
	  @organisation = Organisation.find(params[:organisation_id])
		if !contributor?(@organisation)
	 		redirect_to organisation_path(@organisation)
	 	end
  end

  def check_admin
		if !@contributor.admin?
 			redirect_to organisation_path(@organisation)
 		end
  end

end
