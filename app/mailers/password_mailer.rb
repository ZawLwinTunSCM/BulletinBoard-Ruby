class PasswordMailer < ApplicationMailer
    def new_email
        @token=params[:user].signed_id(expires_in: 1.minute,purpose:"password_reset")
        mail(to: params[:user].email, subject: "Have You Requested Password Reset?")
      end
end
