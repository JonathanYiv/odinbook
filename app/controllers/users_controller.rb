class UsersController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user = User.find(params[:id])
    @user.update_attribute(:bio, params[:user][:bio])
    flash[:success] = "Profile updated."
    redirect_back(fallback_location: @user)
  end

  def destroy
  end
end
