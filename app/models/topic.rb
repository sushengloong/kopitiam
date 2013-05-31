class Topic < ActiveRecord::Base
  include PgSearch

  before_save :refresh_treat_score

  validates :title, presence: true
  validates :user, presence: true

  belongs_to :user

  has_many :treats
  has_many :treating_users, through: :treats, source: :user
  has_many :comments

  scope :popular, ->{ includes(:user).order('treat_score desc') }
  scope :fresh, ->{ includes(:user).order('created_at desc') }

  self.per_page = 10

  pg_search_scope :search, against: [:title, :link, :text],
      using: {tsearch: {dictionary: "english"}},
      associated_against: {user: :username, comments: [:content]},
      ignoring: :accents

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
