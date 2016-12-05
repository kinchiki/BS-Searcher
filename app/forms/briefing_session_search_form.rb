class BriefingSessionSearchForm
  include ActiveModel::Model

  REGISTRABLE_ATTRIBUTES = %i(
    sf_location sf_start_date sf_finish_date sf_start_time sf_finish_time
    sf_head_office sf_from_emp_num sf_to_emp_num sf_sub_str sf_sub
  )
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
    results = BriefingSession.includes(:company).references(:company)
    # results = BriefingSession
    results = results.place(sf_location).date_between(sf_start_date, sf_finish_date).time_between(sf_start_time, sf_finish_time)
    results = results.merge(Company.employees_between(sf_from_emp_num, sf_to_emp_num))
    results = results.merge(Company.include_sub(sf_sub))
    # results = results.references(:company).merge(Company.employees_between(sf_from_emp_num, sf_to_emp_num))

    results.order(:bs_date, :start_time)
  end

end
