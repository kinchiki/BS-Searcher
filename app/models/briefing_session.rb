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

  scope :place, -> loc {
    where(location: loc) if loc.present?
  }

  scope :date_between, -> from, to {
    if from.present? && to.present?
      where(bs_date: from..to)
    elsif from.present?
      where('bs_date >= ?', from)
    elsif to.present?
      where('bs_date <= ?', to)
    end
  }

  scope :time_between, -> from, to {
    if from.present? && to.present?
      # where('start_time >= ? and start_time < ? finish_time <= ?', from, to, to)
      where(start_time: from...to).where('finish_time <= ?', to)
    elsif from.present?
      where('start_time >= ?', from)
    elsif to.present?
      where('finish_time <= ?', to)
    end
  }

  scope :com_conect, -> { includes(:company).references(:company) }
end
