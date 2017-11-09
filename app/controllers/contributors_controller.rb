class ContributorsController < ApplicationController
	before_action :check_contributor, only: [ :index,  :upapproved_contributor, :approve_contributor ]
	before_action :check_admin, only: [ :upapproved_contributor ]
	before_action :disable_admin_deletion, only: [ :uncontribute ]

	def index

	end

	def create
		@new_contributor = Contributor.new(user_id: current_user.id, organisation_id: params[:organisation_id], role: 0, approval_request:false)
		 @organisation = Organisation.find(params[:organisation_id])
		if @new_contributor.save
	  	flash[:notice]= "You've requested to contribute"
  		redirect_to organisation_path(@organisation)
  	end
	end

	def uncontribute
		if @destroy_contributor.user_id == current_user.id || @contributor.admin?
			if @destroy_contributor.destroy
				flash[:notice]= "You've uncontributed"
	  		redirect_to organisation_path(@organisation)
	  	end
	  end
	end

	def unapproved_contributors
		@unapproved_contributors = Contributor.where(organisation_id: params[:organisation_id
			]).where( approval_request: false )
	end

	def approve_contributor
		@unapproved_contributors = Contributor.where(organisation_id: params[:organisation_id
			]).where( approval_request: false )
		@approve_contributor = @unapproved_contributors.find(params[:id])
		@approve_contributor.approval_request = true
		@approve_contributor.save
		redirect_to unapproved_contributors_path(@organisation)
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

  def disable_admin_deletion
		@organisation = Contributor.find(params[:id]).organisation
  	@contributor = @organisation.contributors.find_by(user_id: current_user.id)
  	@destroy_contributor = Contributor.find(params[:id])
  	if @destroy_contributor.admin?
  		redirect_to organisation_contributors_path(@destroy_contributor.organisation)
  	end
  end

end
