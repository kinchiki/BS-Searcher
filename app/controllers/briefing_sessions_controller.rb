class BriefingSessionsController < ApplicationController
  def index
    @search_form = BriefingSessionSearchForm.new
    # @bs_result = @search_form.search
    #binding.pry
    # @search_form = BriefingSessionSearchForm.new
    # @bs_s ||= BriefingSession.order(:company_id)
  end

  def search
    @search_form = BriefingSessionSearchForm.new(params[:search])
    @bs_result = @search_form.search
  end

  def show
    @bs = BriefingSession.find(params[:id])
  end

  # private
  # 検索フォームから受け取ったパラメータ
  # def search_params
  #   params
  #     .require(:search_product)
  #     .permit(Search::Product::ATTRIBUTES)
  # end

end
