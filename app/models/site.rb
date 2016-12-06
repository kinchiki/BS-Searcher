class Site < ActiveRecord::Base
  has_many :urls#, :dependent => :destroy
  validates :site_name, presence: true, uniqueness: true

  scope :site_select, -> sites {
    where(id: sites) if sites.present?
  }

end
