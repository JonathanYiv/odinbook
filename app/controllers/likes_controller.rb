class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.user = User.find(params[:user_id])
    @like.likeable = Post.find(params[:post_id])
    @like.save
    redirect_to root_path
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to root_path
  end
end
