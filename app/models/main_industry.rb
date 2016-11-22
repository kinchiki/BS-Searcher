class MainIndustry < ActiveRecord::Base
  has_many :sub_industry

  validates :main_t, presence: true, uniqueness: true, length: { in: 1..30 }
end
