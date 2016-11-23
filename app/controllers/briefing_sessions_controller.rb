class BriefingSessionsController < ApplicationController
  def show
    @bs = BriefingSession.find(params[:id])
  end
end
