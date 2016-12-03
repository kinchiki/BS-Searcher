class CompaniesController < ApplicationController
  def index
    @coms ||= Company.order(:id)
  end

  def show
    @com = Company.find(params[:id])
  end
end
