class BriefingSessionSearchForm
  include ActiveModel::Model

  attr_accessor :location, :bs_date, :start_time, :finish_time

  def matches
    results = BriefingSession
    results = results.where(location: location) if location.present?
    results = results.where(bs_date: bs_date) if bs_date.present?
    results = results.where(start_time: start_time) if start_time.present?
    results = results.where(finish_time: finish_time) if finish_time.present?
    # results = results.joins(:address).where("address.tel" =&gt; tel) if tel.present?

    results
  end

end
