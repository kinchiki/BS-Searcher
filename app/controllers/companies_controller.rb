class CompaniesController < ApplicationController
  def index
    @coms ||= Company.all
  end

  def show
    @com = Company.find(params[:id])
  end
end
