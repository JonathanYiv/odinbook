class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash.now[:info] = "Your comment is too long."
      render 'static_pages#home'
    end
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

    # Only the commenter can delete their comment
    def correct_user
      @comment = Comment.find(params[:id])
      unless current_user == @comment.user
        flash[:warning] = "You are not authorized to do that."
        redirect_back(fallback_location: root_path)
      end
    end
end
