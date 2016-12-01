# BriefingSessionSearchForm
      # datetime_parats = params[:briefing_session_search_form]
            # params[:sf_bs_date] = (1..3).map { |i| params.delete("sf_bs_date(#{i}i)") }.join("-")
        # if params[:briefing_session_search_form]["#{attribute}(1i)"] == 1 && params[:briefing_session_search_form]["#{attribute}(4i)"].empty?
        #   params[attribute] = ""
        # else
        # params[attribute] = Time.zone.local(*time_parts).to_s(:time) if time_parts.any?
          # params[attribute] = Time.zone.local(*time_parts).to_s(:time) if time_parts[0] != "1" && time_parts[3].present?
      # end







# require 'bundler/setup'
# require 'open-uri'
# require 'nokogiri'

# doc = Nokogiri::HTML::parse(open('data/html/rikinabi_company.html'))

# main_type = doc.xpath("//td[@class='company-information-detail']")[0]
# # sub_type = doc.xpath("//span[@class='u-db u-fs14']").text

# employees_number = doc.xpath("//td[@class='company-data-td']")
# # employees_number.each { |e|
# #   p e.text
# #   puts
# # }
# # puts

# tmp = doc.xpath("//th[@class='company-data-th']")
# p tmp.text
# puts

# p tmp[tmp.text.index("従業員数")]
# # tmp.each_with_index { |node, i|
# #   if node.text == "従業員数"
# #     break
# #   end
# # }
# puts


# n = employees_number[3].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i
# p n
# puts

# main_type.children.each { |e| p e.text  }
# puts


# # #<Nokogiri::XML::Element:0x3ffe34569dbc name="th" attributes=[#<Nokogiri::XML::Attr:0x3ffe34569d44 name="class" value="company-data-th">] children=[#<Nokogiri::XML::Element:0x3ffe345697b8 name="span" attributes=[#<Nokogiri::XML::Attr:0x3ffe345696f0 name="id" value="03000003584462">]>, #<Nokogiri::XML::Text:0x3ffe345691c8 "従業員数">]>



# require 'bundler/setup'
# require 'anemone'
# require 'nokogiri'
# require_relative 'class/BriefingSession.rb'

# def bfs_scraping(doc, bf_sessions)
#   time = doc.xpath("//th[@class='gh_evt_col02_02']")
#   loc = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
#   shimekiri = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")

#   (time.size).times do |i|
#     next if shimekiri[i].text == "受付終了"
#     next if shimekiri[i].text == "－"
#     bs = BriefingSession.new
#     bs.location = loc[i].text
#     bs.date = time[i].text[0..9]

#     st = time[i].text[14..18]#.sub("：", ":")
#     st[2] = ':'
#     bs.start_time = st

#     ft = time[i].text[-5..-1]
#     ft[2] = ':'
#     bs.finish_time = ft

#     bf_sessions << bs

#     # puts "開催日-" + time[i].text[0..9] + ", 開催地-" + loc[i].text
#     # puts "開始-" + time[i].text[14..18].sub("：", ":") + ", 終了-" + time.text[-5..-1].sub("：", ":")
#   end

# end

# urls = [
#   "https://job.rikunabi.com/2017/company/seminars/r483800020/",
#   "https://job.rikunabi.com/2017/company/seminars/r591800074/",
#   # "https://job.rikunabi.com/2017/company/seminars/r531320090/",
#   # "https://job.rikunabi.com/2017/company/seminars/r578300040/",
#   # "https://job.rikunabi.com/2017/company/seminars/r360900064/",
# ]

# opts = {
#   depth_limit: 1,
#   skip_query_strings: false,
#   obey_robots_txt: true,
#   read_timeout: 5
# }

# bf_sessions = []
# Anemone.crawl(urls, opts) do |anemone|
#   pat = %r(https://job.rikunabi.com/2017/company/seminar/r\d{9}/C0[01][1-9]/)
#   p pat

#   #pat = Regexp.compile(s+n.to_s)
#   #p pat
#   anemone.focus_crawl do |page|
#     page.links.keep_if { |link| link.to_s.match(pat) }
#   end

#   anemone.on_every_page do |page|
#     # puts page.url
#     bfs_scraping(page.doc, bf_sessions) if page.url.to_s =~ pat
#    end

# end

# puts 'id,c_id,date,strat_time,finish_time,location'
# bf_sessions.each { |e| e.show_data }


  # main_type = doc.xpath("//td[@class='dev-company-informationCommon-detail']").first.text.sub(/／.+/) { |match| "" }
  # sub_type = doc.xpath("//span[@class='dev-company-informationCommon-detail-small']").text
  # puts main_type
  # puts sub_type


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