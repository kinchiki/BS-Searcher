require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

# 1.upto(2) do |n|
  # url = "https://job.rikunabi.com/2017/search/seminar/result/?pn=#{n.to_s}"
  url = "https://job.rikunabi.com/2017/search/seminar/result/?dd=20161216&dd=20161217&dd=20161218&dd=20161219&dd=20161220&dd=20161221&dd=20161222&dd=20161223&dd=20161224&dd=20161225&dd=20161226&dd=20161227&dd=20161228&dd=20161229&dd=20161230&dd=20161231&b=89&b=90&b=91&b=92"
  doc = Nokogiri::HTML(open(url))
  nodesets = doc.xpath("//div[@class='search-cassette-title']/a")

  nodesets.each do |node|
    puts "'https://job.rikunabi.com#{node[:href]}',"
  end
  sleep 1
# end