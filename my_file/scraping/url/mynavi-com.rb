require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

url = "http://job.mynavi.jp/17/pc/search/query.html?OP:5/"
doc = Nokogiri::HTML(open(url))
nodesets = doc.xpath("//h3/a")

nodesets.each do |node|
  u = node[:href]
  u.sub!("flex", "outline") if u.include?("flex")
  puts "'http://job.mynavi.jp#{u}',"
end
