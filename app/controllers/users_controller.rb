class UsersController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
