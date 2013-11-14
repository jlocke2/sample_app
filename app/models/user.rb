class User < ActiveRecord::Base
  has_many :pictures, dependent: :destroy

  has_many :microposts, dependent: :destroy
  

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


	has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy


  
  has_many :messages, foreign_key: "sender_id", dependent: :destroy
  has_many :senders, through: :reverse_messages, source: :sender

  has_many :reverse_messages, foreign_key: "receiver_id", 
                              class_name: "Messages", 
                              dependent: :destroy
  has_many :receivers, through: :messages, source: :receiver



  before_save { self.email = email.downcase }
  before_save { self.user_name = user_name.downcase.gsub(/\s+/, "")}
	before_create :create_remember_token

  mount_uploader :avatar, AvatarUploader


  def self.from_param(param)
    find_by(user_name: param)
  end

  def to_param 
    
      user_name.parameterize
    
 end
  
 

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

   def feed
      Micropost.from_users_followed_by(self)
   end

   def inbox
    Message.order('id desc').messages_to(self)
   end

   def outbox
     Message.messages_from(self)
   end

   def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end




	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
              format: { with: VALID_EMAIL_REGEX }, 
              uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
    validates :user_name, presence: true,
              uniqueness: {message: "'%{value}' has already been taken"}
            # alternative syntax
            # :uniqueness => {:message => "'%{value}' has already been taken"}


    private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

   
end
