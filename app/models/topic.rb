class Topic < ActiveRecord::Base
  validates :title, presence: true
  validates :user, presence: true

  belongs_to :user

  has_many :treats
  has_many :treating_users, through: :treats, source: :user
  has_many :comments

  scope :fresh, ->{ order('created_at desc') }

  # TODO this is very inefficient. To change this method to scope
  def self.popular
    self.all.sort_by { |x| -x.treat_score }
  end

  def link_domain_name
    link.blank? ? nil : URI.parse(link).host
  end

  def treat_score
    treats.inject(0) { |sum, treat| sum + treat.value }
  end
end
