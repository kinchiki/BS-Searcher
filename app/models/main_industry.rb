class MainIndustry < ActiveRecord::Base
  has_many :sub_industries#, :dependent => :destroy

  validates :main_t, presence: true, uniqueness: true, length: { in: 1..20 }
end
