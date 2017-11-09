class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      post_ids = current_user.friends.pluck(:id)
      post_ids << current_user.id
      # Attempt at fixing N + 1 Queries
      @posts = Post.includes(:likes).includes(comments: [:user, :likes]).includes(:user).paginate(page: params[:page], per_page: 10)
      # @posts = Post.paginate(page: params[:page], per_page: 10)
    end
  end

  def about
  end

  def contact
  end
end
