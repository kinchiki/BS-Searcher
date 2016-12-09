require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/Company.rb'
require_relative '../../class/BriefingSession.rb'

DOMAIN = "https://job.mynavi.jp"

def cp_scrape(doc)
  # company = Company.new

  # company.name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+\］|【.+】|／.+)+/, '')
  # head = doc.xpath("//div[@class='place']/dl/dd")
  # company.head_office = head[0].text.sub(/(\r|\n|\t)+/, '')
  # company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  # if head[3].nil?
  #   company.employees_number = 0
  # else
  #   company.employees_number = head[3].text.sub(/名.+/, '').sub(/[^\d]+/, "").delete(",").to_i
  # end

  # company.show_data
  # puts
  DOMAIN + doc.xpath("//a[@id='doSeminar']").first[:href]
end

def get_bs_url(url)
  doc = Nokogiri::HTML.parse(open(url))
  bss = doc.xpath("//h3[@class='hdg01']/a")
  bs_urls = []
  bss.each do |bs|
    bs_urls << DOMAIN + bs[:href]
  end
  bs_urls
end

def bs_scrape(url)
  doc = Nokogiri::HTML.parse(open(url))
  bss = []

  bs = BriefingSession.new
  locations = doc.xpath("//td[@class='area']")
  dates = doc.xpath("//td[@class='date']")
  times = doc.xpath("//td[@class='time']")




end

urls = [
'https://job.mynavi.jp/17/pc/search/corp102816/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp83820/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp52644/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp202711/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp68756/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp92934/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp92316/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp211471/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp205629/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp64691/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp63983/outline.html',
# 'https://job.mynavi.jp/17/pc/search/corp72425/outline.html',
]

urls.each do |com_url|
  bs_urls = get_bs_url( cp_scrape(Nokogiri::HTML.parse(open(com_url))) )
  bs_urls.each do |bs_url|
    bs_scrape(bs_url)
    sleep 1
  end
  sleep 1
end
