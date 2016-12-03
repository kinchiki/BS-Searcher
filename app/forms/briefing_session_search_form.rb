class BriefingSessionSearchForm
  include ActiveModel::Model

  REGISTRABLE_ATTRIBUTES = %i(sf_location sf_start_date sf_finish_date sf_start_time sf_finish_time)
  attr_accessor(*REGISTRABLE_ATTRIBUTES)

  def initialize(params = {})
    if params.is_a?(ActionController::Parameters)
      # ハッシュからdeleteするとそのキーの値が返る
      [:sf_start_time, :sf_finish_time].each do |attribute|
        time_parts = (4..5).map { |i| params.delete("#{attribute}(#{i}i)") }
        params[attribute] = time_parts.join(":") unless time_parts[0].empty?
      end
    end
    super
  end

  def matches
    BriefingSession.place(sf_location).date_between(sf_start_date, sf_finish_date).time_between(sf_start_time, sf_finish_time).order(:bs_date,:start_time)
    # results = results.joins(:address).where("address.tel" =&gt; tel) if tel.present?
  end

end
