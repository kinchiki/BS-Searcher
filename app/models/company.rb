class Company < ActiveRecord::Base
  has_many :briefing_sessions, :dependent => :destroy
  belongs_to :sub_industry

  validates :com_name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :head_office, presence: true, length: { in: 2..20 }
  validates :employees_number, presence: true, numericality: { only_integer: true, less_than: 350000 }
  # validates :sub_industry_id, presence: true
end
