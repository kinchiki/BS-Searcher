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
