require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/BriefingSession.rb'

DOMAIN = "https://job.mynavi.jp"

def bs_scrape(doc)
  bss = []

  locations = doc.xpath("//td[@class='area']")
  dates = doc.xpath("//td[@class='date']")
  times = doc.xpath("//td[@class='time']")

  (times.size).times do |i|
    # next if deadline[i].text == "受付終了"
    # next if deadline[i].text == "－"
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

bs_scrape(Nokogiri::HTML.parse(open("https://job.mynavi.jp/17/pc/corpinfo/displaySeminar/index?optNo=IIgtXC&corpId=2369")))