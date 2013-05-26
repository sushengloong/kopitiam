class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :content, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
