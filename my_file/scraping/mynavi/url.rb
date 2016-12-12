require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

url = "https://job.mynavi.jp/17/pc/search/query.html?SK:seminar/IC:40,41,42/LICM:1/SDT:Y2016,M12,P1M/OP:5/func=PCtopQuickSearchSem"
#https://job.mynavi.jp/17/pc/search/query.html?SK:seminar/IC:40,41,42/LICM:1/SDT:Y2016,M12,P1M/OP:5/func=PCtopQuickSearchSem
doc = Nokogiri::HTML(open(url))
nodesets = doc.xpath("//h3/a")

nodesets.each do |node|
  u = node[:href]
  u.sub!("flex", "outline") if u.include?("flex")
  puts "'https://job.mynavi.jp#{u}',"
end
