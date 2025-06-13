# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @chats = Chat.for_user(current_user)
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
  end

  def update
    if @chat.update(chat_params)
      redirect_to chat_path(@chat), notice: "Chat updated successfully."
    else
      render :edit
    end
  end

  def destroy
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