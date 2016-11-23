class BriefingSession < ActiveRecord::Base
  belongs_to :company
  has_many :briefing_session_urls, dependent: :destroy
  has_many :urls, through: :briefing_session_urls, dependent: :destroy
  # 関連項目も含めて一度に保存、削除するよ、らしい
  # accepts_nested_attributes_for :briefing_session_urls, allow_destroy: true

  # validates :company_id, numericality: { only_integer: true }#presence: true,
  validates :location, presence: true, length: { in: 2..12 }
  validates :bs_date, presence: true
  # validates :start_time, presence: true
  # validates :finish_time, presence: true
end
