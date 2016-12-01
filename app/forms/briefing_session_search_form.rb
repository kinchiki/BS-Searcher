class BriefingSessionSearchForm
  include ActiveModel::Model

  REGISTRABLE_ATTRIBUTES = %i(sf_location sf_bs_date sf_start_time sf_finish_time)
  attr_accessor(*REGISTRABLE_ATTRIBUTES)

  def initialize(params = {})
    if params.is_a?(ActionController::Parameters)
      # ハッシュからdeleteするとそのキーの値が返る
      date_parts = (1..3).map { |i| params.delete("sf_bs_date(#{i}i)") }
      params[:sf_bs_date] = date_parts.join("-") if date_parts.any?

      [:sf_start_time, :sf_finish_time].each do |attribute|
        time_parts = (4..5).map { |i| params.delete("#{attribute}(#{i}i)") }
        params[attribute] = time_parts.join(":") unless time_parts[0].empty?
      end
    end
    super
  end

  def matches
    results = BriefingSession
    results = results.where('location like ?', "%#{sf_location}%") if sf_location.present?
    results = results.where(bs_date: sf_bs_date) if sf_bs_date.present?
    if sf_start_time.present? && sf_finish_time.present?
      results = results.where(start_time: sf_start_time...sf_finish_time)
      results = results.where(finish_time: sf_start_time..sf_finish_time)
    else
      results = results.where(start_time: sf_start_time) if sf_start_time.present?
      results = results.where(finish_time: sf_start_time) if sf_finish_time.present?
    end
    # results = results.joins(:address).where("address.tel" =&gt; tel) if tel.present?

    results.order(:start_time)
  end

end
