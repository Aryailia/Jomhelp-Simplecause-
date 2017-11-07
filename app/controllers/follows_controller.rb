class FollowsController < ApplicationController

def follow_user
    @user = User.find_by! user_name: params[:user_name]
end 

def unfollow_user 

	@user = User.find_by! user_name: params[:user_name]
    if current_user.unfollow @user.id
end

