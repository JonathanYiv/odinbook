class CommentsController < ApplicationController
  before_action :logged_in_user
  # Incorrect users can destroy other user's comments.
  
  def create
    @comment = current_user.comments.new(post_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash.now[:info] = "Your comment is too long."
      render 'static_pages#home'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:comment).permit(:content, :post_id)
    end
end
