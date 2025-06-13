# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    unless current_user.admin?
      redirect_to chats_path, alert: "You don't have permission to view all users."
      return
    end
    
    @users = User.all
  end

  def show
    @sent_chats = @user.sent_chats
    @received_chats = @user.received_chats
    @messages = @user.messages
  end

  def edit
  
  end


  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to chats_path, notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end