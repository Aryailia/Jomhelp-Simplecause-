class FollowsController < ApplicationController

# def new 
# 	@organisation = Organisation.find(params[:organisation_id])
# 	@follow = Follow.new
# end 

	def show
	end 

	def create
		if signed_in?
			@organisation = Organisation.find(params[:organisation_id])
			@follow = Follow.new(organisation_id: @organisation.id, user_id: current_user.id)
			if @follow.save 
				flash[:notice] = "You've followed this organisation"
				redirect_to organisation_path(@organisation)
			else
				flash[:notice] = "You've already followed this organisation"
				redirect_to organisation_path(@organisation)
			end
		else
			flash[:notice] = "You must log in to follow"
			redirect_to organisation_path(@organisation)
		end
	end 

	def destroy
		if signed_in? 
			@follow = Follow.find_by(organisation_id: params[:organisation_id], user_id: current_user.id)
			@follow.destroy
			flash[:notice] = "You've unfollowed this organisation"
			redirect_to organisation_path(@follow.organisation)
		else
			flash[:notice] = "You must log in to unfollow"
			redirect_to organisation_path(@organisation)
		end
	end 
end 
# 	@user = User.find_by! user_name: params[:user_name]
#    if current_user.unfollow @user.id
# end

