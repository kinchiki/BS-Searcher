require 'bundler/setup'
require 'anemone'
require 'nokogiri'
require_relative '../class/Company.rb'
require_relative '../class/BriefingSession.rb'

# opts = {
#   depth_limit: 1,
#   skip_query_strings: true,
#   obey_robots_txt: true,
#   read_timeout: 5
# }

urls = [
  'https://job.rikunabi.com/2017/company/top/r158800081/',
  # 'https://job.rikunabi.com/2017/company/top/r697430013/',
  # 'https://job.rikunabi.com/2017/company/top/r732800083/',
  # 'https://job.rikunabi.com/2017/company/top/r334620050/',
]

def bfs_scrape(doc, bf_sessions, cp_id)
  times = doc.xpath("//th[@class='gh_evt_col02_02']")
  locations = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
  deadline = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

  (times.size).times do |i|
    next if deadline[i].text == "受付終了"
    next if deadline[i].text == "－"

    bs = BriefingSession.new
    bs.company_id = cp_id
    bs.location = locations[i].text
    bs.date = times[i].text[0..9]

    time = times[i].text[14..-1].tr('：',':')
    bs.start_time  = time[0..4]
    bs.finish_time = time[-5..-1]

    bf_sessions << bs
  end
end

def cp_scrape(doc)
  company = Company.new
  #メイン業種のリストを予め作っておき、そっからマッチしたものを取り出すとか
  #cssのclassを書き換えて抽出する？

  company.name = doc.xpath("//h1[@class='company-title-main']").text
  #company.main_type = doc.xpath("//td[@class='company-information-detail']").first.text
  #company.sub_type = doc.xpath("//span[@class='u-db u-fs14']").text
  company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text == "従業員数"
      e_index = i
      break
    end
  }
  company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i

  company
end

def ane(url, cp_id, bf_sessions)
  Anemone.crawl(url, {depth_limit: 1,skip_query_strings: true,obey_robots_txt: true,read_timeout: 5}) do |anemone|
    pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)

    anemone.focus_crawl do |page|
      page.links.keep_if { |link| link.to_s.match(pat) }
    end

    anemone.on_every_page do |page|
      bfs_scrape(page.doc, bf_sessions, cp_id) if page.url.to_s =~ pat
     end

  end
end


companies = []
bf_sessions = []

urls.each do |top_url|
  cp = cp_scrape(Nokogiri::HTML.parse(open(top_url)))
  top_url[38,3] = 'seminars'
  ane(top_url, cp.id, bf_sessions)
  # bfs_scrape(Nokogiri::HTML.parse(open(top_url), bf_sessions, cp.id))
  companies << cp
end



puts 'ID,企業名,副業種ID,本社所在地,従業員数'
companies.each do |cp|
  cp.show_data
end

puts

puts 'id,c_id,date,strat_time,finish_time,location'
bf_sessions.each do |e|
  # companies[e.company_id].show_data
  e.show_data
end