class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @chats = Chat.all
  end

  def show
    @messages = @chat.messages
    @sender = @chat.sender
    @receiver = @chat.receiver
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.sent_chats.build(chat_params)
    
    if @chat.save
      redirect_to chat_path(@chat), notice: "Chat created successfully."
    else
      render :new
    end
  end

  def edit
    unless can?(:update, @chat)
      redirect_to chat_path(@chat), alert: "You cannot edit chats where you don't participate."
      return
    end
  end

  def update
    unless can?(:update, @chat)
      redirect_to chat_path(@chat), alert: "You cannot edit chats where you don't participate."
      return
    end
    
    if @chat.update(chat_params)
      redirect_to chat_path(@chat), notice: "Chat updated successfully."
    else
      render :edit
    end
  end

  def destroy
    unless can?(:destroy, @chat)
      redirect_to chats_path, alert: "You cannot delete chats where you don't participate."
      return
    end

    @chat.destroy
    redirect_to chats_path, notice: "Chat deleted successfully."
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end