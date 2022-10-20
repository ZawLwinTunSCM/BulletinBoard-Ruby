class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize_admin
    redirect_to login_path unless current_user
  end

  def login?
    redirect_to users_path if current_user
  end

  def isCurrentUser(id)
    current_user.id == id
  end

  helper_method :current_user, :login?, :isCurrentUser

end
