class EmploymentInformationSite
  attr_accessor :id, :site_name
  @@number = 1

  def initialize
    @id = @@number # サイトid
    @site_name = "" # サイト名
    @@number += 1
  end

end
