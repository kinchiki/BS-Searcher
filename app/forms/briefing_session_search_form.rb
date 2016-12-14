class BriefingSessionSearchForm
  include ActiveModel::Model

  REGISTRABLE_ATTRIBUTES = %i(
    sf_location sf_start_date sf_finish_date sf_start_time sf_finish_time
    sf_head_office sf_from_emp_num sf_to_emp_num sf_sub sf_ho
    sf_site
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
    # results = BriefingSession.includes(:company).references(:company) どっちがいい？
    results = BriefingSession.includes(:company, urls: :site).joins(:company, urls: :site)

    # 説明会情報での検索
    results = results.place(sf_location).date_between(sf_start_date, sf_finish_date).time_between(sf_start_time, sf_finish_time)

    # 企業情報での検索
    results = results.merge(Company.employees_between(sf_from_emp_num, sf_to_emp_num)).merge(Company.include_sub(sf_sub)).merge(Company.search_head(sf_ho))

    # 就職情報サイトでの検索
    results = results.merge(Site.site_select(sf_site))

    results.order(:bs_date, :start_time)
  end
end
