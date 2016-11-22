class BriefingSessionUrl < ActiveRecord::Base
  belongs_to :briefing_session
  belongs_to :url
end
