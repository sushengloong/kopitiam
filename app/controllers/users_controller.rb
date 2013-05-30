class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
    render :show and return unless is_current_user? @user
  end

  def update
    @user = User.find params[:id]
    render :show and return unless is_current_user? @user
    if @user.update_attributes(user_params)
      redirect_to edit_user_path(@user), notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  def update_password
    @user = User.find params[:id]
    render :show and return unless is_current_user? @user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to edit_user_path(@user), notice: "Password changed successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :username, :avatar, :current_password, :password, :password_confirmation)
  end
end
