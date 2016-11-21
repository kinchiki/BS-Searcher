require 'open-uri'

def cp_scrape(doc)
  company = Company.new

  company.com_name = doc.xpath("//h1[@class='company-title-main']").text.gsub(/(\s|　|株式会社)+/,'')
  company.head_office = doc.xpath("//td[@class='company-information-detail']")[1].text
  company.sub_str = doc.xpath("//td[@class='company-information-detail']")[0].children[1].text

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    # if node.text =~ /●?従業員数|社員数/
    if node.text == ("従業員数"||"社員数")
      e_index = i
      break
    end
  }
  if e_index == 0
    company.employees_number = 0
  else
    company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/(名|人).+/,"").tr("０-９", "0-9").sub(/[^\d]+/, "").delete(",").to_i
  end

  company.save
end


urls = [
]

# companies = []
urls.each do |url|
  cp_scrape(Nokogiri::HTML.parse(open(url)))
  sleep 1
_# end

# companies.each do |com|
#   com.save
# end
