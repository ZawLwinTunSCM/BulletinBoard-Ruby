class UsersController < ApplicationController

  before_action :authorize_admin

  def index
    if params[:name].present?
      @users = UserService.getUserByName(params[:name])
    else
      @users = UserService.list(current_user.id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.created_user = current_user.id
    @is_save = UserService.createUser(@user)
    if @is_save
        redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = UserService.getUserByID(params[:id])
  end

  def edit
    if isCurrentUser(params[:id].to_i) || current_user.admin_flg
      @user = UserService.getUserByID(params[:id])
    else
      render file: "#{Rails.root}/public/422.html", layout: false
    end
  end

  def update
    @user = UserService.getUserByID(params[:id])
    @user.updated_user = current_user.id
    @is_user_update = UserService.updateUser(@user, user_params)
    if @is_user_update
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = UserService.getUserByID(params[:id])
    UserService.destroyUser(@user)
    redirect_to users_path
  end

  def edit_password
    :edit_password_path
  end

  def update_password
    if params[:password].blank? && params[:password_confirmation].blank?
      redirect_to edit_password_path, notice: "Please Enter Passwod and Password Comfirmation."
    elsif params[:password].blank? && params[:password_confirmation] != nil
      redirect_to edit_password_path, notice: "Please Enter Passwod."
    elsif params[:password] != nil && params[:password_confirmation].blank?
      redirect_to edit_password_path, notice: "Please Enter Passwod Confirmation."
    elsif params[:password] != params[:password_confirmation]
      redirect_to edit_password_path, notice: "Passwod and Confirm Password must be the same."
    elsif params[:password].length < 3
      redirect_to edit_password_path, notice: "Password must be at least 3 characters."
    else
      @user = current_user
      @is_update_password = UserService.updatePassword(@user, params[:password])
      if @is_update_password
        redirect_to users_path
      end
    end
  end
  
  def user_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation, :phone,
     :address, :birthday,:profile, :admin_flg, :created_user, :updated_user)
  end
  
end
