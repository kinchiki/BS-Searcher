require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../class/Company.rb'

def scraping(cp,doc)
  cp.name = doc.xpath("//h1[@class='company-title-main']").text
  #メイン業種のリストを予め作っておき、そっからマッチしたものを取り出すとか
  #classを書き換えて抽出する？
  cp.main_type = doc.xpath("//td[@class='company-information-detail']").first.text
  cp.sub_type = doc.xpath("//span[@class='u-db u-fs14']").text
  cp.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text == "従業員数"
      e_index = i
      break
    end
  }
  cp.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i
end


urls = [
  'https://job.rikunabi.com/2017/company/top/r484700037/',
  'https://job.rikunabi.com/2017/company/top/r716010091/',
  'https://job.rikunabi.com/2017/company/top/r970600081/',
  'https://job.rikunabi.com/2017/company/top/r285500049/',
]

companies = []
urls.each do |url|
  doc = Nokogiri::HTML.parse(open(url))
  company = Company.new
  scraping(company,doc)
  companies << company
end

companies.each do |cp|
  cp.show_data
  puts
end
