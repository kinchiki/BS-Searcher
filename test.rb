require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require 'kconv'

urls = [
  "https://job.rikunabi.com/2017/company/seminars/r716010091/",
  "https://job.rikunabi.com/2017/company/seminars/r970600081/",
  "https://job.rikunabi.com/2017/company/seminars/r285500049/",
  "https://job.rikunabi.com/2017/company/seminars/r248500020/",
  "https://job.rikunabi.com/2017/company/seminars/r586591050/",
  "https://job.rikunabi.com/2017/company/seminars/r158800081/",
  "https://job.rikunabi.com/2017/company/seminars/r429300045/",
  "https://job.rikunabi.com/2017/company/seminars/r360900064/",
  "https://job.rikunabi.com/2017/company/seminars/r324700026/",
]

opts = {
  depth_limit: 2,
  skip_query_strings: false,
  obey_robots_txt: true,
  read_timeout: 5
}

Anemone.crawl(urls, opts) do |anemone|
  pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)

  #pat = Regexp.compile(s+n.to_s)
  #p pat
  anemone.focus_crawl do |page|
    print "forcus : "
    puts page.url
    page.links.keep_if { |link|
      link.to_s.match(pat)
    }
  end

  anemone.on_every_page do |page|
    #p page.doc.xpath("/html/body/div[1]/div[3]/div/ul/li[5]/div[1]/div[2]/div[1]/a").attribute('href').text
    print "every : "
    puts page.url
   end

end


  #PATTERN = %r(.+/company/seminar/r\d{9}+/)
  #PATTERN = %r(.+/company/seminars/r\d{9}+/)
  #PATTERN = %r(.+/company/top/r\d{9}+/)
  #str = "/https:\/\/job.rikunabi.com\/2017\/search\/seminar\/result\/\?ms=1&isc=ps055&pn=#{num}/"
  #PATTERN = str
  #PATTERN = %r(https://job.rikunabi.com/2017/search/seminar/result/\?ms=1&isc=ps055&pn=\d{1,40})

  # s = "https://job.rikunabi.com/2017/search/seminar/result/\?ms=1&isc=ps055&pn="
  # n = 2





# /を抜いて数値としか比較するか？
# /を-に変換して日付として比較するか
#t = Time.now.to_a
#n = (t[5].to_s+t[4].to_s+t[3].to_s).to_i
#p n
#now = t.year + t.


# require 'date'
# t = Time.now
# n = ""

# a = t.to_a

# n = a[5].to_s+a[4].to_s+a[3].to_s
# p n.to_i


# se = "2016/11/08".gsub("/", "-")
# p se
# dd = Time.new("20161108")
# p dd
# d = Time.new(2016,11,8)
# p d
# day = Date.today
# p day.to_s

# require 'bundler/setup'
# require 'nokogiri'

# doc = Nokogiri::HTML.parse(open('./data/rikunabi_setumekai.html'))

# p doc.class
# p doc.class.superclass.superclass
# p doc.class.superclass.superclass.superclass
# p doc.class.superclass.superclass.superclass.superclass
# p doc.class.superclass.superclass.superclass.superclass.superclass


#s = "https:\/\/job.rikunabi.com\/2017\/search\/seminar\/result\/\?ms=1&isc=ps055&pn="

# s = "https://job.rikunabi.com/2017/search/seminar/result/\?ms=1&isc=ps055&pn="
# n = 2
# while n < 40
#   p s + n.to_s
#   n += 1
# end

# pa = Regexp.compile(s+n.to_s)
# p pa