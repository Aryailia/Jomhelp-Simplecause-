class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(:friend_id => params[:friend_id])
    @friendship.approved = false
    @friendship.save
    redirect_to users_show_path(params[:friend_id])
  end

  def destroy   
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:friend_id])
    @friendship.destroy
    redirect_to profile_path
  end

  def approve
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:friend_id])
    @friendship.approved = true
    @friendship.save
    @new_friendship = current_user.friendships.new(:friend_id => params[:friend_id])
    @new_friendship.approved = true
    @new_friendship.save
    redirect_to profile_path
  end

  # def deny
  # end
end