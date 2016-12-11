require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/BriefingSession.rb'

DOMAIN = "https://job.mynavi.jp"

def bs_scrape(doc)
  sleep 1
  bss = []

  locations = doc.xpath("//td[@class='area']")
  dates = doc.xpath("//td[@class='date']")
  times = doc.xpath("//td[@class='time']")

  (times.size).times do |i|
    next if dates[i].text == "上記以外の日程を希望"
    next unless times[i].text.size == 10 || times[i].text.size ==11

    bs = BriefingSession.new

    loc = locations[i].text
    if loc == "東京"
      bs.location = "東京都"
    elsif loc == "大阪" || loc == "京都"
      bs.location = loc + "府"
    elsif loc == "北海道"
        bs.location = loc
    else
      bs.location = loc + "県"
    end

    bs.bs_date = dates[i].text[0..9]
    bs.start_time  = times[i].text[0..4].delete("～")
    bs.finish_time = times[i].text[-5..-1].delete("～")

    bs.show_data
    bss << bs
  end

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
]

urls.each do |url|
  doc = Nokogiri::HTML.parse(open(url))
  seminar_links = doc.xpath("//h3[@class='hdg01']/a")
  if seminar_links.empty?
    bs_scrape(doc)
  else
    get_bs_urls(seminar_links).each { |bs_url|
      bs_scrape(Nokogiri::HTML.parse(open(bs_url)))
    }
  end
end
