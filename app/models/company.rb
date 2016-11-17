class Company < ActiveRecord::Base
  has_many :briefing_sessions, :dependent => :destroy
end
