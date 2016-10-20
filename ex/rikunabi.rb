require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require 'kconv'

# urls = [
#  "https://job.rikunabi.com/2017/company/seminar/",
#  "https://job.rikunabi.com/2017/search/seminar/result/?dd=20161014&k=21&k=22&k=23&k=24"
# ]

#%r(/company/top/r\d{9}+/)

url = "https://job.rikunabi.com/2017/search/seminar/result/"
#https://job.rikunabi.com/2017/search/seminar/result/?ms=1&moduleCd=2&isc=ps055&pn=3
#https://job.rikunabi.com/2017/search/seminar/result/?ms=1&isc=ps055&pn=2
opts = {
  depth_limit: 10,
  skip_query_strings: false,
  obey_robots_txt: true,
  read_timeout: 10
}

Anemone.crawl(url, opts) do |anemone|
  #PATTERN = %r(.+/company/seminar/r\d{9}+/)
  #PATTERN = %r(.+/company/seminars/r\d{9}+/)
  #PATTERN = %r(.+/company/top/r\d{9}+/)
  #str = "/https:\/\/job.rikunabi.com\/2017\/search\/seminar\/result\/\?ms=1&isc=ps055&pn=#{num}/"
  #PATTERN = str
  #PATTERN = %r(https://job.rikunabi.com/2017/search/seminar/result/\?ms=1&isc=ps055&pn=\d{1,40})

  s = "https://job.rikunabi.com/2017/search/seminar/result/\?ms=1&isc=ps055&pn="
  n = 2

  pa = Regexp.compile(s+n.to_s)
  p pa
  anemone.focus_crawl do |page|
    print "forcus : "
    puts page.url
    page.links.keep_if { |link|
      link.to_s.match(pa)
    }
  end

  anemone.on_every_page do |page|
    p page.doc.xpath("/html/body/div[1]/div[3]/div/ul/li[5]/div[1]/div[2]/div[1]/a").attribute('href').text
    print "every : "
    puts page.url
   end
        n += 1

end
