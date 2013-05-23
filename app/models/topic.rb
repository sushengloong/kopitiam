class Topic < ActiveRecord::Base
  validates :title, presence: true
  validates :user, presence: true

  belongs_to :user

  def link_domain_name
    link.blank? ? nil : URI.parse(link).host
  end
end
