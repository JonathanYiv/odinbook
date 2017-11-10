class FriendshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_friendship, only: [:destroy, :accept]
  before_action :involved_user, only: :destroy
  before_action :requestee_user, only: :accept
  before_action :not_friends, only: :create

  def index
  end

  def create
    @friendship = Friendship.new(requester: current_user, requested: @requested)
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
      @friendship ||= Friendship.find_by(id: params[:friendship_id])
      @friendship ||= Friendship.find_by(id: params[:id])
      @friendship
    end

    # Ensures that the user is either the requester or requestee in the friend request
    def involved_user
      unless @friendship.requester == current_user || @friendship.requested == current_user
        flash[:warning] = "You are not authorized."
        redirect_to root_path
      end
    end

    # Ensures that the user is the requestee in the friend request
    def requestee_user
      unless @friendship.requested == current_user
        flash[:warning] = "You are not authorized."
        redirect_to root_path
      end
    end

    # Ensures that the users aren't already friends
    def not_friends
      @requested = User.find(params[:friend_id])
      if current_user.friend?(@requested)
        flash[:success] = "You're already friends!"
        redirect_to @requested
      end
    end
end
