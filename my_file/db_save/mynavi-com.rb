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
]

urls.each do |com_url|
  cp_scrape(Nokogiri::HTML.parse(open(com_url)))
  sleep 1
end
