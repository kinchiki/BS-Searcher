require 'open-uri'

def cp_scrape(doc)
  company = Company.new

  company.com_name = doc.xpath("//h1[@class='company-title-main']").text
  #company.sub_type = doc.xpath("//span[@class='u-db u-fs14']").text
  company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text == "従業員数"
      e_index = i
      break
    end
  }
  company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i

  company
end


urls = [
  'https://job.rikunabi.com/2017/company/top/r149681093/',
  'https://job.rikunabi.com/2017/company/top/r607081087/',
  'https://job.rikunabi.com/2017/company/top/r716800050/',
  'https://job.rikunabi.com/2017/company/top/r202700097/',
  'https://job.rikunabi.com/2017/company/top/r334620050/',
  'https://job.rikunabi.com/2017/company/top/r414820057/',
  'https://job.rikunabi.com/2017/company/top/r531320090/',
  'https://job.rikunabi.com/2017/company/top/r139611099/',
  'https://job.rikunabi.com/2017/company/top/r687010049/',
  'https://job.rikunabi.com/2017/company/top/r483800020/',
]

companies = []
urls.each do |url|
  companies << cp_scrape(Nokogiri::HTML.parse(open(url)))
end

companies.each do |com|
  p com
end
