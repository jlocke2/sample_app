class Message < ActiveRecord::Base
	belongs_to :sender, class_name: "User" 
	belongs_to :receiver, class_name: "User" 
	default_scope -> { order('created_at DESC') } 
	#important to consider defining default scope for each model.
	#Can be overridden by class method applied to specific instance 
	#example  def self.created_before(time)
    #           where("created_at < ?", time)
    #           end
    #         end

def self.messages_to(user)



    receive_user_id = "SELECT receiver_id FROM messages
                       WHERE receiver_id = :user_id"

	where("receiver_id IN (#{receive_user_id})", user_id: user.id)

	#user_id: user.id
	
end

def self.messages_from(user)
	sent_user_ids = "SELECT sender_id FROM messages
                     WHERE sender_id = :user_id"

      where("sender_id IN (#{sent_user_ids})", user_id: user.id)

end

end
