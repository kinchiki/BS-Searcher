class URL
  attr_accessor :id, :url, :bs_id, :site_id
  @@number = 1

  def initialize(n=0,m=0)
    @id = @@number # URLid
    @bs_id = n # BrefingSession#url_id
    @site_id = m # EmploymentInformationSite#id
    @url = "" # url
    @@number += 1
  end

  def show_data
    puts "#{@bs_id},#{@site_id},#{@url}"
  end

end