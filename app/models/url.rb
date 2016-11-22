class Url < ActiveRecord::Base
  belongs_to :briefing_session
  belongs_to :site

  validates :url_val, presence: true, uniqueness: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
