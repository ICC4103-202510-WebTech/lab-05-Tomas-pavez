# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :messages, dependent: :destroy
  
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :different

 
  scope :for_user, ->(user) { where("sender_id = ? OR receiver_id = ?", user.id, user.id) }

  def users
    [sender, receiver]
  end

  def includes_user?(user)
    sender_id == user.id || receiver_id == user.id
  end

  
  def other_participant(current_user)
    if sender_id == current_user.id
      receiver
    else
      sender
    end
  end

  private

  def different
    if sender_id == receiver_id
      errors.add(:receiver_id, "Sender and receiver must be different")
    end
  end
end