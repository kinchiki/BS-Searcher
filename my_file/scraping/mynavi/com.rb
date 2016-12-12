require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/Company.rb'
require_relative '../../class/BriefingSession.rb'

def cp_scrape(doc)
  company = Company.new

  company.name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, '')
  head = doc.xpath("//div[@class='place']/dl/dd")
  company.head_office = head[0].text.sub(/(\r|\n|\t)+/, '')
  company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  if head[3].nil?
    company.employees_number = 0
  else
    company.employees_number = head[3].text.sub(/名.+/, '').sub(/[^\d]+/, "").delete(",").to_i
  end

  company.show_data
  puts
end

urls = [
]

urls.each do |com_url|
  cp_scrape(Nokogiri::HTML.parse(open(com_url)))
  sleep 1
end
