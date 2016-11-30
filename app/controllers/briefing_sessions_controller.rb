class BriefingSessionsController < ApplicationController
  def index
    @search_form = BriefingSessionSearchForm.new
    # @bs_s ||= BriefingSession.order(:company_id)
  end

  def search
    # binding.pry
    @search_form = BriefingSessionSearchForm.new(search_params)
    @bs_results = @search_form.matches
  end

  def show
    @bs = BriefingSession.find(params[:id])
  end

  private
  def search_params
    params.require(:briefing_session_search_form).permit(:location, :bs_date, :start_time, :finish_time)
    # params.require(:briefing_session_search_form).permit(BriefingSessionSearchForm::REGISTRABLE_ATTRIBUTES)
  end
end
