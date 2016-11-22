class BriefingSession < ActiveRecord::Base
  belongs_to :company
  has_many :url

  validates :company_id, presence: true, numericality: { only_integer: true }
  validates :location, presence: true, length: { in: 2..20 }
  validates :bs_date, presence: true
  # validates :start_time, presence: true
  # validates :finish_time, presence: true
end
