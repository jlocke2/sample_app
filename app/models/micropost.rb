class Micropost < ActiveRecord::Base

	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: {maximum: 140}
	validates :user_id, presence: true
  validates :response, presence: true

 before_save :edit_response


 



  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"

    in_reply_ids =  "SELECT response FROM microposts
                    WHERE response = :user_name"


    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR response 
           IN (#{in_reply_ids})",
           user_id: user.id, user_name: user.user_name)
  end

  private

    def edit_response
     if self.content.start_with?("@")
       self.response = self.content.slice(1..-1).split(" ")[0]
     end
    end


end 
