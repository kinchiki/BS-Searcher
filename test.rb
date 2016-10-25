require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require_relative 'class/BriefingSession.rb'

def bfs_scraping(doc, bf_sessions)
  time = doc.xpath("//th[@class='gh_evt_col02_02']")
  loc = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
  shimekiri = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

  (time.size).times do |i|
    next if shimekiri[i].text == "受付終了"
    next if shimekiri[i].text == "－"
    bs = BriefingSession.new
    bs.location = loc[i].text
    bs.date = time[i].text[0..9]

    st = time[i].text[14..18]#.sub("：", ":")
    st[2] = ':'
    bs.start_time = st

    ft = time[i].text[-5..-1]
    ft[2] = ':'
    bs.finish_time = ft

    bf_sessions << bs

    # puts "開催日-" + time[i].text[0..9] + ", 開催地-" + loc[i].text
    # puts "開始-" + time[i].text[14..18].sub("：", ":") + ", 終了-" + time.text[-5..-1].sub("：", ":")
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
  p pat

  #pat = Regexp.compile(s+n.to_s)
  #p pat
  anemone.focus_crawl do |page|
    page.links.keep_if { |link| link.to_s.match(pat) }
  end

  anemone.on_every_page do |page|
    # puts page.url
    bfs_scraping(page.doc, bf_sessions) if page.url.to_s =~ pat
   end

end

puts 'id,c_id,date,strat_time,finish_time,location'
bf_sessions.each { |e| e.show_data }