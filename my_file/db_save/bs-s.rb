def bfs_scrape(doc, bf_sessions, c_id)
  times = doc.xpath("//th[@class='gh_evt_col02_02']")
  locations = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
  deadline = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

  (times.size).times do |i|
    # エラーが発生する説明会があったら正規表現でやればいい
    # または例外処理
    next if deadline[i].text == "受付終了"
    next if deadline[i].text == "－"
    next unless times[i].text.size == 25

    bs = BriefingSession.new
    bs.company_id = c_id
    bs.location = locations[i].text
    bs.bs_date = times[i].text[0..9]

    time = times[i].text[14..-1].tr('：',':')
    bs.start_time  = time[0..4]
    bs.finish_time = time[-5..-1]

    bf_sessions << bs
  end
end

def get_company_id(doc)
  c_name = doc.xpath("//div[@class='dev-company-title-main']").text.gsub(/(\s|　|株式会社)+/,'')
  search_name = Company.find_by_com_name(c_name)
  unless search_name.nil?
    search_name.id
  else
    false
  end
end

urls = [
'https://job.rikunabi.com/2017/company/seminars/r483800020/',
'https://job.rikunabi.com/2017/company/seminars/r639530023/',
'https://job.rikunabi.com/2017/company/seminars/r334620050/',
'https://job.rikunabi.com/2017/company/seminars/r687010049/',
'https://job.rikunabi.com/2017/company/seminars/r648320091/',
]
opts = {
  depth_limit: 1,
  skip_query_strings: false,
  obey_robots_txt: true,
  read_timeout: 5
}

bf_sessions = []
urldb = []
pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)

Anemone.crawl(urls, opts) do |anemone|

  anemone.focus_crawl do |page|
    page.links.keep_if { |link| link.to_s.match(pat) }
  end

  anemone.on_every_page do |page|
    doc = page.doc
    company_id = get_company_id(doc)
    if company_id
      bfs_scrape(doc, bf_sessions, company_id ) if page.url.to_s =~ pat
      # urldb << URL.new(page.url)
    end
   end

end

bf_sessions.each { |e| p e }
p bf_sessions.size
