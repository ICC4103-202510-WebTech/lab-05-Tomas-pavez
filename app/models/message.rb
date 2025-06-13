class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  validates :body, presence: true
  validate :user_must_be_in_chat

private

  def user_must_be_in_chat
    return unless chat && user
    
    unless chat.sender_id == user.id || chat.receiver_id == user.id
      errors.add(:chat_id, "No puedes crear mensajes en un chat donde no participas")
    end
  end
end
