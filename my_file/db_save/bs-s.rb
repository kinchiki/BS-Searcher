def bfs_scrape(doc, bsu, c_id, url)
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

    bsu[url] << bs
  end
end

def get_company_id(doc)
  c_name = doc.xpath("//div[@class='dev-company-title-main']").text.gsub(/(\s|　|株式会社)+/,'')
  search_name = Company.find_by(com_name: c_name)
  unless search_name.nil?
    search_name.id
  else
    false
  end
end

urls = [
]
opts = {
  depth_limit: 1,
  skip_query_strings: false,
  obey_robots_txt: true,
  read_timeout: 5
}

bsu = Hash.new { |h, k| h[k] = [] }
pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)

Anemone.crawl(urls, opts) do |anemone|
  i = 1
  anemone.focus_crawl do |page|
    page.links.keep_if { |link| link.to_s.match(pat) }
  end

  anemone.on_every_page do |page|
    doc = page.doc
    company_id = get_company_id(doc)
    if company_id
      url = page.url.to_s
      if url =~ pat
        bfs_scrape(doc, bsu, company_id, url) unless Url.exists?(url_val: url)
      p i = i+1
      end
    end
    # sleep 1
  end

end

bsu.each do |url,bs_all|
  u = Url.new(url_val: url, site_id: 1)
  if u.save
    bs_all.each do |bs|
     p BriefingSessionUrl.create(briefing_session_id: bs.id, url_id: u.id) if bs.save
    end
  end
end
