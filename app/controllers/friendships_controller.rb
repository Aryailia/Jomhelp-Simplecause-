class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(:friend_id => params[:friend_id])
    @friendship.approved = false
    @friendship.save
    redirect_to users_show_path(params[:friend_id])
  end

  def destroy    
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
  end
end