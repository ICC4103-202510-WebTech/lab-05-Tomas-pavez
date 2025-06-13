# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  has_many :messages, dependent: :destroy
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
  has_many :received_messages, through: :received_chats, source: :messages

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
     
  def chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end

 
  def admin?
    id == 1
  end
end