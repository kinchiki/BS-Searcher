require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../class/Company.rb'

def cp_scrape(doc)
  company = Company.new
  #メイン業種のリストを予め作っておき、そっからマッチしたものを取り出すとか
  #cssのclassを書き換えて抽出する？

  company.name = doc.xpath("//h1[@class='company-title-main']").text
  #company.main_type = doc.xpath("//td[@class='company-information-detail']").first.text
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
  'https://job.rikunabi.com/2017/company/top/r732800083/',
  'https://job.rikunabi.com/2017/company/top/r334620050/',
  'https://job.rikunabi.com/2017/company/top/r322960025/',
  'https://job.rikunabi.com/2017/company/top/r621800079/',
]

companies = []
urls.each do |url|
  companies << cp_scrape(Nokogiri::HTML.parse(open(url)))
end

puts 'ID,企業名,副業種ID,本社所在地,従業員数'
companies.each do |cp|
  cp.show_data
end
