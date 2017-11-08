class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @like = Like.new
    @like.user = User.find(params[:user_id])
    if params[:post_id]
      @like.likeable = Post.find(params[:post_id])
    else
      @like.likeable = Comment.find(params[:comment_id])
    end
    @like.save
    redirect_to root_path
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to root_path
  end
end
