class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @sent_chats = @user.sent_chats
    @received_chats = @user.received_chats
    @messages = @user.messages
  end

  def new
    @user = User.new
  end

  def edit
    unless can?(:update, @user)
      redirect_to user_path(@user), alert: "You cannot edit another user's profile."
      return
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def update
    unless can?(:update, @user)
      redirect_to user_path(@user), alert: "You cannot edit another user's profile."
      return
    end
    
    if @user.update(user_params)
      redirect_to @user, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    unless can?(:destroy, @user)
      redirect_to users_path, alert: "You cannot delete other users."
      return
    end

    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end