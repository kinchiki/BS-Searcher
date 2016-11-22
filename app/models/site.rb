class Site < ActiveRecord::Base
  has_many :url
  validates :site_name, presence: true, uniqueness: true
end
