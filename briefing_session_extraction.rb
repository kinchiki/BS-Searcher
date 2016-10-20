require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'kconv'

# 1.upto(2) do |n|
  url = "https://job.rikunabi.com/2017/search/seminar/result/?ms=1&isc=ps055&pn=1"# + n.to_s

  doc = Nokogiri::HTML(open(url))

  nodesets = doc.xpath("//div[@class='search-cassette-actionBar-cell search-cassette-actionBar-cell_04']/a")
  nodesets.each do |node|
    puts node[:href]
  end
# end