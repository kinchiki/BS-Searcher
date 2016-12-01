class BriefingSessionSearchForm
  include ActiveModel::Model

  # REGISTRABLE_ATTRIBUTES = %i(location bs_date start_time finish_time)
  attr_accessor :location, :bs_date, :start_time, :finish_time

  def initialize(params = {})
    if params.is_a?(ActionController::Parameters)
      date_parts = (1..3).map { |i| params.delete("bs_date(#{i}i)") }
      params[:bs_date] = date_parts.join("-") if date_parts.any?

      [:start_time, :finish_time].each do |attribute|
        time_parts = (1..5).map { |i| params.delete("#{attribute}(#{i}i)") }
        params[attribute] = Time.zone.local(*time_parts).to_s(:time) if time_parts.any?
      end
    end
    super
  end

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
