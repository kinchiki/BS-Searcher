class EmploymentInformationSite
  @@number = 1

  def initialize
    @id = @@number # サイトid
    @site_name = "" # サイト名
    @@number += 1
  end

end
