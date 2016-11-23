class BriefingSessionsController < ApplicationController
  def index
    @bs_s ||= BriefingSession.order(:company_id)
  end

  def show
    @bs = BriefingSession.find(params[:id])
  end
end
