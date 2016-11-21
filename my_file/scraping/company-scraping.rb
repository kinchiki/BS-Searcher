require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../class/Company.rb'

def cp_scrape(doc)
  company = Company.new
  company.name = doc.xpath("//h1[@class='company-title-main']").text.tr("株式会社","").gsub(/(\s|　)+/,'')
  company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text

  # type = doc.xpath("//td[@class='company-information-detail']")[0].children
  # main_type = type[0].text
  # sub_type = type[1].text

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text == "従業員数"
      e_index = i
      break
    end
  }
  company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.tr("０-９", "0-9").sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i

  company
end


urls = [
'https://job.rikunabi.com/2017/company/top/r531320090/',
'https://job.rikunabi.com/2017/company/top/r149681093/',
'https://job.rikunabi.com/2017/company/top/r451581003/',
'https://job.rikunabi.com/2017/company/top/r340420058/',
'https://job.rikunabi.com/2017/company/top/r202700097/',
'https://job.rikunabi.com/2017/company/top/r414820057/',
'https://job.rikunabi.com/2017/company/top/r394130001/',
'https://job.rikunabi.com/2017/company/top/r716800050/',
'https://job.rikunabi.com/2017/company/top/r586591050/',
'https://job.rikunabi.com/2017/company/top/r483800020/',
]

companies = []
urls.each do |url|
  companies << cp_scrape(Nokogiri::HTML.parse(open(url)))
end

puts 'ID,企業名,副業種ID,本社所在地,従業員数'
companies.each do |cp|
  cp.show_data
end
