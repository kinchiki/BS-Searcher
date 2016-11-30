class BriefingSessionSearchForm
  include ActiveModel::Model

  REGISTRABLE_ATTRIBUTES = %i(
    location
    bs_date(1i) bs_date(2i) bs_date(3i)
    start_time(1i) start_time(2i) start_time(3i) start_time(4i) start_time(5i)
    start_time finish_time
  )

  attr_accessor :location, :bs_date, :start_time, :finish_time#,"bs_date(1i)", "bs_date(2i)", "bs_date(3i)"
  # attr_accessor REGISTRABLE_ATTRIBUTES

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
