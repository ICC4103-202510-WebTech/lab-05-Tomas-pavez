class User < ApplicationRecord
  has_many :messages
  has_many :sent_chats, class_name: 'Chat'
  has_many :received_chats, class_name: 'Chat'
  has_many :received_messages, through: :received_chats, source: :messages

  validates :email, presence: true, uniqueness: true
end
