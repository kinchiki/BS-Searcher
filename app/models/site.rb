class Site < ActiveRecord::Base
  has_many :urls#, :dependent => :destroy
  validates :site_name, presence: true, uniqueness: true
end
