require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require 'kconv'
require 'open-uri'

url = "https://job.rikunabi.com/2017/search/seminar/result/?n=1"
charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

puts html

# doc = Nokogiri::HTML(open("https://job.rikunabi.com/2017/search/seminar/result/?dd=20161014&k=21&k=22&k=23&k=24"))

# p doc.html

=begin

opts = {
  depth_limit: 1,
  skip_query_strings: true
}
#http://kinchiki-it.hatenablog.jp/entry/editor-impressions
Anemone.crawl(urls, opts) do |anemone|
  PATTERN = %r(/C0\d{1,2}/)

#  anemone.on_pages_like(PATTERN) do |page|
#    puts page.url
#  end
 anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(PATTERN)
    }
  end

  anemone.on_every_page do |page|
     puts page.url
   end

end

=end
