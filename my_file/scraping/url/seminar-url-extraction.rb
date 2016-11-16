require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

1.upto(3) do |n|
  url = "https://job.rikunabi.com/2017/search/seminar/result/?pn=#{n.to_s}"
  doc = Nokogiri::HTML(open(url))
  nodesets = doc.xpath("//div[@class='search-cassette-title']/a")

  nodesets.each do |node|
    puts node[:href]
  end
  sleep 1
end