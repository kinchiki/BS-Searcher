require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require_relative '../class/BriefingSession.rb'

def bfs_scrape(doc, bf_sessions)
  times = doc.xpath("//th[@class='gh_evt_col02_02']")
  locations = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
  deadline = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

  (times.size).times do |i|
    # エラーが発生する説明会があったら正規表現でやればいい
    # または例外処理
    next if deadline[i].text == "受付終了"
    next if deadline[i].text == "－"

    bs = BriefingSession.new
    bs.location = locations[i].text
    bs.date = times[i].text[0..9]

    time = times[i].text[14..-1].tr('：',':')
    bs.start_time  = time[0..4]
    bs.finish_time = time[-5..-1]

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
    bfs_scrape(page.doc, bf_sessions) if page.url.to_s =~ pat
   end

end

puts 'id,c_id,date,strat_time,finish_time,location'
bf_sessions.each { |e| e.show_data }