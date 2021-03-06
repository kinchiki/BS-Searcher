class BriefingSessionsController < ApplicationController
  def index
    @search_form = BriefingSessionSearchForm.new
    # @bs_s ||= BriefingSession.order(:company_id)
  end

  def search
    @search_form = BriefingSessionSearchForm.new(search_params)
    @bs_results = @search_form.matches

    # 時間が文字列だとフォーム作成時にエラーになる
    if @search_form.sf_start_time.present? && @search_form.sf_finish_time.present?
      @search_form.sf_start_time  = @search_form.sf_start_time.to_i
      @search_form.sf_finish_time = @search_form.sf_finish_time.to_i
    elsif @search_form.sf_start_time.present?
      @search_form.sf_start_time  = @search_form.sf_start_time.to_i
    elsif @search_form.sf_finish_time.present?
      @search_form.sf_finish_time = @search_form.sf_finish_time.to_i
    end
    # binding.pry
  end

  def show
    @bs = BriefingSession.includes(urls: :site).find(params[:id])
  end

  private
  def search_params
    # チェックボックスで複数の値を受け取るものは[]
    params.require(:briefing_session_search_form).permit(BriefingSessionSearchForm::REGISTRABLE_ATTRIBUTES, sf_location: [], sf_sub: [], sf_site: [])
  end
end
