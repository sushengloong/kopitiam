class Topic < ActiveRecord::Base
  before_save :refresh_treat_score

  validates :title, presence: true
  validates :user, presence: true

  belongs_to :user

  has_many :treats
  has_many :treating_users, through: :treats, source: :user
  has_many :comments

  scope :popular, ->{ order('treat_score desc') }
  scope :fresh, ->{ order('created_at desc') }

  self.per_page = 10

  def link_domain_name
    link.blank? ? nil : URI.parse(link).host
  end

  private

  def calc_treat_score
    treats.inject(0) { |sum, treat| sum + treat.value }
  end

  def refresh_treat_score
    self.treat_score = calc_treat_score
  end
end
