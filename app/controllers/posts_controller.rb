class PostsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to root_path
    else
      flash.now[:info] = "Your post is too long."
      render 'static_pages#home'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:warning] = "You are not allowed to delete other people's posts."
    else
      @post.destroy
      flash[:success] = "Your post has been deleted."
    end
    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
