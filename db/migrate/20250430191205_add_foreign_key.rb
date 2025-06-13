class AddForeignKey < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :chats, :users, column: :sender_id
    add_foreign_key :chats, :users, column: :receiver_id
    add_foreign_key :messages, :chats
    add_foreign_key :messages, :users
  end
end
