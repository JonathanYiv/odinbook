class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      post_ids = current_user.friends.pluck(:id)
      post_ids << current_user.id
      @posts = Post.where("user_id in (?)", post_ids)
    end
  end

  def about
  end

  def contact
  end
end
