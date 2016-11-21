urls = [
'https://job.rikunabi.com/2017/company/seminars/r531320090/',
'https://job.rikunabi.com/2017/company/seminars/r149681093/',
'https://job.rikunabi.com/2017/company/seminars/r451581003/',
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
    p c_name = doc.xpath("//div[@class='dev-company-title-main']").text.gsub(/(\s|　|株式会社)+/,'')
    p company_id = Company.find_by_com_name(c_name).id
    # bfs_scrape(doc, bf_sessions) if page.url.to_s =~ pat
    # urldb << URL.new(page.url)
   end

end
