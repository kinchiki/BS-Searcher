class BriefingSessionSearchFormsController < ApplicationController
  def index
    @search_form = BriefingSessionSearchForm.new(params[:search])
    @bs_result = @search_form.search
  end
end
