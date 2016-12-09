require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require_relative '../../class/Company.rb'

def cp_scrape(doc)
  company = Company.new
  company.name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+\］|【.+】|／.+)+/,'')
  p company.name

  head = doc.xpath("//div[@class='place']/dl/dd")
  company.head_office = head[0].text.sub(/(\r|\n|\t)+/,'')
  p company.head_office

  company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  p company.sub_str

  # company.employees_number = head[3]
  # p company.employees_number

  # tmp = doc.xpath("//th[@class='company-data-th']")
  # e_index = 0
  # tmp.each_with_index { |node, i|
  #   # if node.text =~ /(従業|社)員数/
  #   if node.text.include?("従業員数") || node.text.include?("社員数")
  #     e_index = i
  #     break
  #   end
  # }
  # if e_index == 0
  #   company.employees_number = 0
  # else
  #   company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/(名|人).+/,"").tr("０-９", "0-9").sub(/[^\d]+/, "").delete(",").to_i
  # end
  puts
  company

end


urls = [
  'http://job.mynavi.jp/17/pc/search/corp102356/outline.html',
'http://job.mynavi.jp/17/pc/search/corp94059/outline.html',
'http://job.mynavi.jp/17/pc/search/corp112318/outline.html',
'http://job.mynavi.jp/17/pc/search/corp214076/outline.html',
'http://job.mynavi.jp/17/pc/search/corp214657/outline.html',
'http://job.mynavi.jp/17/pc/search/corp94174/outline.html',
]

companies = []
urls.each do |url|
  companies << cp_scrape(Nokogiri::HTML.parse(open(url)))
end

# companies.each do |cp|
#   cp.show_data
# end
