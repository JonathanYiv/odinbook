class FriendshipsController < ApplicationController
  def index
  end

  def create
    @friendship = Friendship.new(requester_id: params[:user_id], requested_id: params[:friend_id])
    @friendship.save
    redirect_to users_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to users_path
  end

  def accept
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.update_attribute(:accepted, true)
    redirect_to friendships_path
  end
end
