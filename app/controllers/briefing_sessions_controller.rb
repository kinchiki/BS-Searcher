class BriefingSessionsController < ApplicationController
  def index
    @search_form = BriefingSessionSearchForm.new
    # @bs_s ||= BriefingSession.order(:company_id)
  end

  def search
    @search_form = BriefingSessionSearchForm.new(search_params)
    @bs_results = @search_form.matches
    # binding.pry
    @search_form = BriefingSessionSearchForm.new if @search_form.sf_start_time.present? || @search_form.sf_finish_time.present?
    #   @search_form.sf_start_time  = ""
    #   @search_form.sf_finish_time = ""
    # binding.pry
  end

  def show
    @bs = BriefingSession.includes(:urls).find(params[:id])
  end

  private
  def search_params
    params.require(:briefing_session_search_form).permit(BriefingSessionSearchForm::REGISTRABLE_ATTRIBUTES, sf_location: [] ,sf_site: [])
  end
end
