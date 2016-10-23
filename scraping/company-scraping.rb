require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require '../class/Company.rb'

url = 'https://job.rikunabi.com/2017/company/top/r484700037/'
doc = Nokogiri::HTML.parse(open(url))

company = Company.new

company.name = doc.xpath("//h1[@class='company-title-main']").text
p company.name

#メイン業種のリストを予め作っておき、そっからマッチしたものを取り出すとか
#classを書き換えて抽出する？
company.main_type = doc.xpath("//td[@class='company-information-detail']").first.text
p company.main_type

company.sub_type = doc.xpath("//span[@class='u-db u-fs14']").text
p company.sub_type

c = doc.xpath("//th[@class='company-data-th']")
e_index = 0
c.each_with_index { |node, i|
  if node.text == "従業員数"
    e_index = i
    break
  end
}

company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i
#company.employees_number = doc.xpath("/html/body/div[1]/div[2]/div/div[8]/table/tbody/tr[4]/td")
p company.employees_number

company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text
p company.head_office