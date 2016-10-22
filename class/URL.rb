class URL
  @@number = 1

  def initialize(n,m)
    @id = @@number # URLid
    @url = "" # url
    @bf_id = n # BrefingSession#url_id
    @site_id = m # EmploymentInformationSite#id
    @@number += 1
  end

end