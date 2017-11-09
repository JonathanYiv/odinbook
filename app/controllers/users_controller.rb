class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:update, :destroy]

  def index
    @users = User.where.not(id: current_user.id).paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user.update_attribute(:bio, params[:user][:bio])
    flash[:success] = "Profile updated."
    redirect_back(fallback_location: @user)
  end

  def destroy
    @user.destroy
    flash[:success] = "Your account has been deleted."
    redirect_to root_path
  end

  private

    # Ensures that you can only update and delete accounts that are your own
    def correct_user
      @user = User.find(params[:id])
      unless current_user == @user
        flash[:warning] = "You are not authorized to do that."
        redirect_to root_path
      end
    end
end
