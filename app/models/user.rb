class User < ApplicationRecord
  
  #validates :name, :mobile, :gender,:username , :dob, :email, presence: true
  #validates :mobile, length: {is:10}

  has_many :posts ,dependent: :destroy
  has_many :comments , dependent: :destroy
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2, :facebook ]


 attr_writer :login

  def login
	    @login || self.username || self.email || self.mobile
  end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(mobile) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email) || condition.has_key?(:mobile)
        where(conditions.to_h).first
      end
  end


  def self.from_omniauth(access_token)
    data = access_token.info

    user = User.where( email: data[:email]).first
      # Uncomment the section below if you want users to be created if they don't exist
      unless user
        user = User.create(name: data[:name],
              email: data[:email],
              password: Devise.friendly_token[0,20],
              uid: data[:uid],
              provider: data[:provider],
              username: Devise.friendly_token[0,3],
              mobile:Devise.friendly_token[0,10])
      end
      user
  end


  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions  


  def existing_chats_users
    existing_chat_users = []
    self.chats.each do |chat|
      existing_chat_users.concat(chat.subscriptions.where.not(user_id: self.id).map {|subscription| subscription.user})
    end    
    existing_chat_users.uniq
  end

end
