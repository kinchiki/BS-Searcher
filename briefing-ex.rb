require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

def show_nodes(nodes, discrption = "説明:")
  nodes.each do |node|
    p discrption + node.text
  end
  puts
end

url = 'https://job.rikunabi.com/2017/company/seminars/r507630058/'

doc = Nokogiri::HTML.parse(open(url))

time = doc.xpath("//th[@class='gh_evt_col02_02']").reverse
show_nodes(time, "開催日時:")

loc = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']").reverse
shimekiri = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']").reverse
# a = []
# shimekiri.each do |node|
#   a << node.text
# end
# p a

company = doc.xpath("//div[@class='dev-company-title-main']")
p company.class
puts company.text
puts

main_type = doc.xpath("//td[@class='dev-company-informationCommon-detail']"). first.text.sub(/／.+/) { |match| "" }
#main_type = doc.xpath("//*[@id='contents']/tbody/tr/td/div[1]/div/table/tbody/tr[1]/td").text
sub_type = doc.xpath("//span[@class='dev-company-informationCommon-detail-small']").text
puts main_type
puts sub_type


(time.size).times do |i|
  next if shimekiri[i].text == "受付終了"
  next if shimekiri[i].text == "－"
  puts "開催日-" + time[i].text[0..9] + ", 開催地-" + loc[i].text
  puts "開始-" + time[i].text[14..18].sub("：", ":") + ", 終了-" + time.text[-5..-1].sub("：", ":")
end
