class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  has_many :messages
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :different
  private

  def different
    if sender_id == receiver_id
      errors.add(:receiver_id, "They must be different")
    end
  end

end