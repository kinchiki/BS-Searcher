require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/BriefingSession.rb'

DOMAIN = "https://job.mynavi.jp"

def bs_scrape(doc)
  bss = []

  bs = BriefingSession.new
  p locations = doc.xpath("//td[@class='area']").text
  p dates = doc.xpath("//td[@class='date']").text
  p times = doc.xpath("//td[@class='time']").text

  puts
end

def get_bs_urls(links)
  bs_urls = []
  links.each do |bs|
    bs_urls << DOMAIN + bs[:href]
  end
  bs_urls
end

urls = [
'https://job.mynavi.jp/17/pc/corp98656/sem.html',
'https://job.mynavi.jp/17/pc/corp107245/sem.html',
'https://job.mynavi.jp/17/pc/corp110527/sem.html',
]

urls.each do |url|
  doc = Nokogiri::HTML.parse(open(url))
  seminar_links = doc.xpath("//h3[@class='hdg01']/a")
  if seminar_links.empty?
    bs_scrape(doc)
  else
    get_bs_urls(seminar_links).each { |bs_url| bs_scrape(Nokogiri::HTML.parse(open(bs_url))) }
    sleep 1
  end
end
