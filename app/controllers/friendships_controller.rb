class FriendshipsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def create
    @friendship = Friendship.new(requester_id: params[:user_id], requested_id: params[:friend_id])
    @friendship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def accept
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.update_attribute(:accepted, true)
    redirect_to @friendship.requester
  end
end
