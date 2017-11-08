class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "Please login."
      redirect_to root_path
    end
  end
end
