class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
