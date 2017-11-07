class PostsController < ApplicationController
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
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
