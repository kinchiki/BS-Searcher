require 'open-uri'

def cp_scrape(doc)
  company = Company.new

  # スペース、(株)、［.+］（全角）、【.+】、／.+、[.+]（半角）、(.+)、（.+）
  company.com_name = doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, '')
  if Company.exists?(com_name: company.com_name)
    p "登録済み"
    puts
    return
  end

  head = doc.xpath("//div[@class='place']/dl/dd")
  company.head_office = head[0].text.sub(/(\r|\n|\t)+/, '')
  company.sub_str = doc.xpath("//div[@class='category']/ul/li/a").text
  if head[3].nil?
    company.employees_number = 0
  else
    company.employees_number = head[3].text.sub(/名.+/, '').sub(/[^\d]+/, "").delete(",").to_i
  end

  if company.save
    p company
  else
    p "失敗"
    p company
  end
  puts
end

urls = [
'https://job.mynavi.jp/17/pc/search/corp100804/outline.html',
'https://job.mynavi.jp/17/pc/search/corp102438/outline.html',
'https://job.mynavi.jp/17/pc/search/corp71334/outline.html',
'https://job.mynavi.jp/17/pc/search/corp83997/outline.html',
'https://job.mynavi.jp/17/pc/search/corp98656/outline.html',
'https://job.mynavi.jp/17/pc/search/corp64026/outline.html',
'https://job.mynavi.jp/17/pc/search/corp213922/outline.html',
'https://job.mynavi.jp/17/pc/search/corp104598/outline.html',
'https://job.mynavi.jp/17/pc/search/corp204711/outline.html',
'https://job.mynavi.jp/17/pc/search/corp210960/outline.html',
'https://job.mynavi.jp/17/pc/search/corp100949/outline.html',
'https://job.mynavi.jp/17/pc/search/corp62526/outline.html',
'https://job.mynavi.jp/17/pc/search/corp88113/outline.html',
'https://job.mynavi.jp/17/pc/search/corp102158/outline.html',
'https://job.mynavi.jp/17/pc/search/corp1423/outline.html',
'https://job.mynavi.jp/17/pc/search/corp96661/outline.html',
'https://job.mynavi.jp/17/pc/search/corp109694/outline.html',
'https://job.mynavi.jp/17/pc/search/corp76971/outline.html',
'https://job.mynavi.jp/17/pc/search/corp213085/outline.html',
'https://job.mynavi.jp/17/pc/search/corp200441/outline.html',
'https://job.mynavi.jp/17/pc/search/corp92182/outline.html',
'https://job.mynavi.jp/17/pc/search/corp201160/outline.html',
'https://job.mynavi.jp/17/pc/search/corp7604/outline.html',
'https://job.mynavi.jp/17/pc/search/corp204285/outline.html',
'https://job.mynavi.jp/17/pc/search/corp17509/outline.html',
'https://job.mynavi.jp/17/pc/search/corp204463/outline.html',
'https://job.mynavi.jp/17/pc/search/corp112473/outline.html',
'https://job.mynavi.jp/17/pc/search/corp92320/outline.html',
'https://job.mynavi.jp/17/pc/search/corp89573/outline.html',
'https://job.mynavi.jp/17/pc/search/corp99533/outline.html',
'https://job.mynavi.jp/17/pc/search/corp204685/outline.html',
'https://job.mynavi.jp/17/pc/search/corp66137/outline.html',
'https://job.mynavi.jp/17/pc/search/corp92126/outline.html',
'https://job.mynavi.jp/17/pc/search/corp207229/outline.html',
'https://job.mynavi.jp/17/pc/search/corp70242/outline.html',
'https://job.mynavi.jp/17/pc/search/corp204069/outline.html',
'https://job.mynavi.jp/17/pc/search/corp207268/outline.html',
'https://job.mynavi.jp/17/pc/search/corp66427/outline.html',
'https://job.mynavi.jp/17/pc/search/corp9149/outline.html',
'https://job.mynavi.jp/17/pc/search/corp52507/outline.html',
'https://job.mynavi.jp/17/pc/search/corp201047/outline.html',
'https://job.mynavi.jp/17/pc/search/corp109574/outline.html',
'https://job.mynavi.jp/17/pc/search/corp110618/outline.html',
'https://job.mynavi.jp/17/pc/search/corp82035/outline.html',
'https://job.mynavi.jp/17/pc/search/corp83221/outline.html',
'https://job.mynavi.jp/17/pc/search/corp97231/outline.html',
'https://job.mynavi.jp/17/pc/search/corp79159/outline.html',
'https://job.mynavi.jp/17/pc/search/corp109728/outline.html',
'https://job.mynavi.jp/17/pc/search/corp200767/outline.html',
'https://job.mynavi.jp/17/pc/search/corp214654/outline.html',
]

urls.each do |com_url|
  cp_scrape(Nokogiri::HTML.parse(open(com_url)))
  sleep 1
end
