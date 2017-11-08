class FollowsController < ApplicationController

# def new 
# 	@organisation = Organisation.find(params[:organisation_id])
# 	@follow = Follow.new
# end 

def show
end 

def create 
	@organisation = Organisation.find(params[:id])
  @follow = Follow.new(organisation_id: @organisation.id, user_id: current_user.id)
  # @follow.oraganisation = @organisation
  if @follow.save 
  	flash[:notice]= "You've followed this organisation"
  	redirect_to organisation_path(@organisation)
   end 
end 

	def destroy 
		@follow = Follow.find_by(organisation_id: params[:id], user_id: current_user.id)
		@follow.destroy
		flash[:notice] = "You've unfollowed this organisation"
		redirect_to organisation_path(@follow.organisation)
	end 
end 
# 	@user = User.find_by! user_name: params[:user_name]
#    if current_user.unfollow @user.id
# end

