require 'open-uri'

def cp_scrape(doc)
  company = Company.new

  company.com_name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+\］|【.+】|／.+)+/, '')
  return if Company.exists?(com_name: company.com_name)

  head = doc.xpath("//div[@class='place']/dl/dd")
  company.head_office = head[0].text.sub(/(\r|\n|\t)+/, '')
  company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  if head[3].nil?
    company.employees_number = 0
  else
    company.employees_number = head[3].text.sub(/名.+/, '').sub(/[^\d]+/, "").delete(",").to_i
  end

  company.save
  p company
  puts
end

urls = [
'https://job.mynavi.jp/17/pc/search/corp102356/outline.html',
'https://job.mynavi.jp/17/pc/search/corp66795/outline.html',
'https://job.mynavi.jp/17/pc/search/corp83820/outline.html',
'https://job.mynavi.jp/17/pc/search/corp74882/outline.html',
'https://job.mynavi.jp/17/pc/search/corp102438/outline.html',
'https://job.mynavi.jp/17/pc/search/corp205629/outline.html',
'https://job.mynavi.jp/17/pc/search/corp214180/outline.html',
'https://job.mynavi.jp/17/pc/search/corp96661/outline.html',
'https://job.mynavi.jp/17/pc/search/corp70038/outline.html',
'https://job.mynavi.jp/17/pc/search/corp200441/outline.html',
]

urls.each do |com_url|
  cp_scrape(Nokogiri::HTML.parse(open(com_url)))
  sleep 1
end
