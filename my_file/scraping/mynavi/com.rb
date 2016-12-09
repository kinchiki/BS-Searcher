require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/Company.rb'

def cp_scrape(doc)
  company = Company.new

  company.name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+\］|【.+】|／.+)+/, '')
  head = doc.xpath("//div[@class='place']/dl/dd")
  company.head_office = head[0].text.sub(/(\r|\n|\t)+/, '')
  company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  company.employees_number = head[3].text.sub(/名.+/, '').delete(",").to_i

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
  puts
end
