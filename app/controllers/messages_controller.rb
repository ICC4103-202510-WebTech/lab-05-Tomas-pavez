class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @chats = current_user.chats
  end

  def create
    @message = current_user.messages.build(message_params)
    
    begin
      authorize! :create, @message
    rescue CanCan::AccessDenied
      flash[:alert] = "You don't have permissions to create messages in this chat"
      @chats = current_user.chats
      render :new and return
    end

    if @message.save
      redirect_to @message, notice: "Message created successfully."
    else
      @chats = current_user.chats
      render :new
    end
  end

  def show
    @user = @message.user
    @chat = @message.chat
  end

  def edit
    unless can?(:update, @message)
      redirect_to message_path(@message), alert: "You cannot edit other users' messages."
      return
    end
  end

  def update
    unless can?(:update, @message)
      redirect_to message_path(@message), alert: "You cannot edit other users' messages."
      return
    end

    if @message.update(message_params)
      redirect_to @message, notice: "Message updated successfully."
    else
      render :edit
    end
  end

  def destroy
    unless can?(:destroy, @message)
      redirect_to messages_path, alert: "You cannot delete other users' messages."
      return
    end

    @message.destroy
    redirect_to messages_path, notice: "Message deleted successfully."
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :chat_id)
  end
end