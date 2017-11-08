class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(:friend_id => params[:friend_id])
    @friendship.save
  end

  def destroy    
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
  end
end