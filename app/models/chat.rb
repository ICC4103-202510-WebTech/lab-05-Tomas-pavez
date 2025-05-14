class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  has_many :messages

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :different

  private

  def different
    if sender_id == receiver_id
      errors.add(:receiver_id, "Sender and receiver must be different")
    end
  end
end
