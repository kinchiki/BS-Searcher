class URL
  attr_accessor :id, :url, :bs_id, :site_id
  # @@number = 1

  def initialize(n=0,m=0)
    # @id = @@number # URLid
    @url = "" # url
    @bs_id = n # BrefingSession#url_id
    @site_id = m # EmploymentInformationSite#id
    @@number += 1
  end

  def show_data
    puts "#{@url},#{@bs_id},#{@site_id}"
  end

end