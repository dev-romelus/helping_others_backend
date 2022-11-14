class Conversation < ApplicationRecord
    belongs_to :sender, class_name: "User", foreign_key: "sender_id"
    belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
    belongs_to :service, class_name: "Service", foreign_key: "service_id"
    has_many :messages, dependent: :destroy
  
    validates_presence_of :sender_id, :receiver_id, :service_id
  
    def recipient(current_user)
      self.sender_id == current_user.id ? self.receiver : self.sender
    end
  
    def unread_message_count(current_user)
      self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
    end
  
  end