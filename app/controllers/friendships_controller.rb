class FriendshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_friendship, only: [:destroy, :accept]
  before_action :involved_user, only: :destroy

  def index
  end

  def create
    @friendship = Friendship.new(requester: current_user, requested_id: params[:friend_id])
    @friendship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  def accept
    @friendship.update_attribute(:accepted, true)
    redirect_to @friendship.requester
  end

  private

    def find_friendship
      @friendship = Friendship.find(params[:friendship_id])
    end

    # Ensures that the user is either the requester or requestee in the friend request
    def involved_user
      @friendship.requester == current_user || @friendship.requested == current_user
    end

    # Ensures that the user is the requestee in the friend request
    def requestee_user
      @friendship.requested == current_user
    end
end
