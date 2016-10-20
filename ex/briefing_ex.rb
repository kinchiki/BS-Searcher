require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

url = 'https://job.rikunabi.com/2017/company/seminar/r248500020/C001/'

doc = Nokogiri::HTML.parse(open(url))

p doc.title
puts

time = doc.xpath("//th[@class='gh_evt_col02_02']")
p time.class
time.each do |item|
   puts "開催日時 : " + item.text
end
puts

loc = doc.xpath("//th[@class='gh_evt_col03 g_txt_C']")
p loc.class
time.each do |item|
  puts "開催地 : " + item.text
end
puts

shimekiri = doc.xpath("//th[@class='gh_evt_col05 g_txt_C']")
p shimekiri.class
shimekiri.each do |item|
  puts "受付締切 : " + item.text
end
puts


#location = doc.xpath("//*[@id='contents']/tbody/tr/td/table[4]/tbody/tr/td/table/tbody/tr/td/table[2]/tbody/tr[5]/td[2]/table/tbody/tr/th[4]/div").text
#//*[@id="contents"]/tbody/tr/td/table[4]/tbody/tr/td/table/tbody/tr/td/table[2]/tbody/tr[5]/td[2]/table/tbody/tr/th[4]/div

#div[@data-component-term='tweet']
#gh_evt_col02_02
