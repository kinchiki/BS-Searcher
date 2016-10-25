require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require_relative 'class/BriefingSession.rb'

def bfs_scraping(doc, bf_sessions)
  times = doc.xpath("//th[@class='gh_evt_col02_02']")
  locations = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
  deadline = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

  (times.size).times do |i|
    next if deadline[i].text == "受付終了"
    next if deadline[i].text == "－"

    bs = BriefingSession.new
    bs.location = locations[i].text
    bs.date = time[i].text[0..9]

    st = time[i].text[14..18]#.sub("：", ":")
    st[2] = ':'
    bs.start_time = st
    ft = time[i].text[-5..-1]
    ft[2] = ':'
    bs.finish_time = ft

    bf_sessions << bs
  end

end

urls = [
  "https://job.rikunabi.com/2017/company/seminars/r483800020/",
  "https://job.rikunabi.com/2017/company/seminars/r591800074/",
  # "https://job.rikunabi.com/2017/company/seminars/r531320090/",
  # "https://job.rikunabi.com/2017/company/seminars/r578300040/",
  # "https://job.rikunabi.com/2017/company/seminars/r360900064/",
]

opts = {
  depth_limit: 1,
  skip_query_strings: false,
  obey_robots_txt: true,
  read_timeout: 5
}

bf_sessions = []
Anemone.crawl(urls, opts) do |anemone|
  pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)

  anemone.focus_crawl do |page|
    page.links.keep_if { |link| link.to_s.match(pat) }
  end

  anemone.on_every_page do |page|
    bfs_scraping(page.doc, bf_sessions) if page.url.to_s =~ pat
   end

end

puts 'id,c_id,date,strat_time,finish_time,location'
bf_sessions.each { |e| e.show_data }