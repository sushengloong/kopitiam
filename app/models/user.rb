class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model (deprecated in rails 4)
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  has_many :topics
  has_many :treats
  has_many :treated_topics, through: :treats, source: :topic
  has_many :comments
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: :topic, order: 'created_at desc'

  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.top_contributors limit = 10
    all.sort_by{ |x| [-x.topics.size, -x.comments.size] }.first(limit)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def has_favorited? topic
    favorite_topics.any? { |t| t.id == topic.id }
  end
end
