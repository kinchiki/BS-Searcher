class Url < ActiveRecord::Base
  belongs_to :site
  has_many :briefing_session_urls, dependent: :destroy
  has_many :briefing_sessions, through: :briefing_session_urls

  validates :url_val, presence: true, uniqueness: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
