require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require './class/Company.rb'

def scraping(cp,doc)
  cp.name = doc.xpath("//h1[@class='company-title-main']").text
  # p c.name

  #メイン業種のリストを予め作っておき、そっからマッチしたものを取り出すとか
  #classを書き換えて抽出する？
  cp.main_type = doc.xpath("//td[@class='company-information-detail']").first.text
  # p c.main_type

  cp.sub_type = doc.xpath("//span[@class='u-db u-fs14']").text
  # p c.sub_type

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text == "従業員数"
      e_index = i
      break
    end
  }

  cp.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i
  #c.employees_number = doc.xpath("/html/body/div[1]/div[2]/div/div[8]/table/tbody/tr[4]/td")
  # p c.employees_number

  cp.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text
  # p c.head_office

end


#url = 'https://job.rikunabi.com/2017/company/top/r484700037/'
urls = [
  'https://job.rikunabi.com/2017/company/top/r484700037/',
  'https://job.rikunabi.com/2017/company/top/r716010091/',
  'https://job.rikunabi.com/2017/company/top/r970600081/',
  'https://job.rikunabi.com/2017/company/top/r285500049/',
]

companies = []
urls.each do |url|
  doc = Nokogiri::HTML.parse(open(url))
  company = Company.new
  scraping(company,doc)
  companies << company
end

companies.each do |cp|
  cp.show_data
  puts
end





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