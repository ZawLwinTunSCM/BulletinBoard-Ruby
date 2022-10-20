class PasswordResetController < ApplicationController
  def email_check
    @user=User.find_by(email: params[:email])
    if @user.present?
      PasswordMailer.with(user: @user).new_email.deliver_now
      redirect_to forgot_password_path, notice: "We will send a password reset link to your email."
    else
      redirect_to forgot_password_path, alert: "Account doesn't exist."
    end
  end
    
  def reset_password
    @user = User.find_signed!(params[:token],purpose:"password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to login_path, notice: "Your token has expired, reset again."
  end

  def update_password
    if password_params[:password].blank? && password_params[:password_confirmation].blank?
      redirect_to reset_password_path(token: params[:token]), notice: "Please Enter Passwod and Password Comfirmation."
    elsif password_params[:password].blank? && password_params[:password_confirmation] != nil
      redirect_to reset_password_path(token: params[:token]), notice: "Please Enter Passwod."
    elsif password_params[:password] != nil && password_params[:password_confirmation].blank?
      redirect_to reset_password_path(token: params[:token]), notice: "Please Enter Passwod Confirmation."
    elsif password_params[:password] != password_params[:password_confirmation]
      redirect_to reset_password_path(token: params[:token]), notice: "Passwod and Confirm Password must be the same."
    elsif password_params[:password].length < 3
      redirect_to reset_password_path(token: params[:token]), notice: "Password must be at least 3 characters."
    else
    @user = User.find_signed(params[:token],purpose:"password_reset")
      if @user.update(password_params)
        redirect_to login_path, alert:"Password reset successfully, please log in again"
      end
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
