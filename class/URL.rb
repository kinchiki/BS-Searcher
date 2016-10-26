class URL
  attr_accessor :id, :url, :bs_id, :site_id
  @@number = 1

  def initialize
    @id = @@number # URLid
    @url = "" # url
    @bs_id = 0 # BrefingSession#url_id
    @site_id = 0 # EmploymentInformationSite#id
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@url},#{@bs_id},#{@site_id}"
  end

end