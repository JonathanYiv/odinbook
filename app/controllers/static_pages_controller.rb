class StaticPagesController < ApplicationController
  def home
    @posts = Post.all # To fix later.
  end

  def about
  end

  def contact
  end
end
