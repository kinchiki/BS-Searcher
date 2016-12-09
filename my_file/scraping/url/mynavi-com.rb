require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

url = "http://job.mynavi.jp/17/pc/search/query.html?OP:5/"
doc = Nokogiri::HTML(open(url))
nodesets = doc.xpath("//h3/a")

nodesets.each do |node|
  puts "'http://job.mynavi.jp/#{node[:href]}',"
end
