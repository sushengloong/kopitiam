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
      redirect_to edit_user_path(@user), notice: "User profile updated successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :username, :avatar)
  end
end
