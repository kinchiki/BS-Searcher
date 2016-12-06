class UrlsController < ApplicationController
  def index
    @urls = Url.all.includes(:site)
  end

  def show
    @url = Url.includes(briefing_sessions: :company).find(params[:id])
  end
end
