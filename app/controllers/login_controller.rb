class LoginController < ApplicationController

  before_action :login?, only: [:loginP]

  def loginP
    session.delete(:user_id)
    @current_user = nil
  end

  def login
    if params[:session][:email].blank? && params[:session][:password].blank?
      redirect_to login_path, notice: "Please Enter Email And Password."
    elsif params[:session][:email].blank? && params[:session][:password] != nil
      redirect_to login_path, notice: "Please Enter Email."
    elsif params[:session][:email] != nil && params[:session][:password].blank?
      redirect_to login_path, notice: "Please Enter Password."
    else 
      user = UserService.findByEmail(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
       session[:user_id] = user.id
       redirect_to users_path
      else 
        redirect_to login_path, notice: "Invalid Email Or Password."
      end
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to login_path
  end
  
end
