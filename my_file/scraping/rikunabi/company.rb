require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../class/Company.rb'

def cp_scrape(doc)
  company = Company.new
  company.name = doc.xpath("//h1[@class='company-title-main']").text.gsub(/(\s|　|株式会社|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, '')
  company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text

  industry = doc.xpath("//td[@class='company-information-detail']")[0].children
  company.sub_str = industry[1].text
  company.sub_str = industry[0].text if company.sub_str.empty?

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    # if node.text =~ /(従業|社)員数/
    if node.text.include?("従業員数") || node.text.include?("社員数")
      e_index = i
      break
    end
  }
  if e_index == 0
    company.employees_number = 0
  else
    company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/(名|人).+/,"").tr("０-９", "0-9").sub(/[^\d]+/, "").delete(",").to_i
  end

  company

end


urls = [
]

companies = []
urls.each do |url|
  companies << cp_scrape(Nokogiri::HTML.parse(open(url)))
end

companies.each do |cp|
  cp.show_data
end
