require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
# このプログラムはいらん
# 1.upto(2) do |n|
  #url = "https://job.rikunabi.com/2017/search/seminar/result/?pn=#{n.to_s}""

  url = 'https://job.rikunabi.com/2017/search/seminar/result/?isc=ps136&b=89&b=90&b=91&b=92&k=21&k=22&k=23&k=24'

  doc = Nokogiri::HTML(open(url))

  nodesets = doc.xpath("//div[@class='search-cassette-actionBar-cell search-cassette-actionBar-cell_04']/a")
  nodesets.each do |node|
    puts node[:href]
  end
# end