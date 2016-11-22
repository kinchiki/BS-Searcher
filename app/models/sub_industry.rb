class SubIndustry < ActiveRecord::Base
  belongs_to :main_industry

  validates :main_industry_id, presence: true, numericality: { only_integer: true }
  validates :sub_t, presence: true, uniqueness: true, length: { maximum: 100 }
end
