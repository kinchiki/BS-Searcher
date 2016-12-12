require 'open-uri'

def cp_scrape(doc)
  company = Company.new

  company.com_name = doc.xpath("//h1[@class='company-title-main']").text.gsub(/(\s|　|株式会社|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, '')
  if Company.exists?(com_name: company.com_name)
    p "登録済み"
    puts
    return
  end

  ho = doc.xpath("//td[@class='company-information-detail']")[1].text
  if ho == "東京"
    company.head_office = "東京都"
  elsif ho == "大阪" || ho == "京都"
    company.head_office = ho + "府"
  elsif ho == "北海道"
      company.head_office = ho
  else
    company.head_office = ho + "県"
  end

  industry = doc.xpath("//td[@class='company-information-detail']")[0].children
  company.sub_str = industry[1].text
  company.sub_str = industry[0].text if company.sub_str.empty?

  tmp = doc.xpath("//th[@class='company-data-th']")
  e_index = 0
  tmp.each_with_index { |node, i|
    if node.text.include?("従業員数") || node.text.include?("社員数")
      e_index = i
      break
    end
  }
  if e_index == 0
    p "従業員数取得できないため中断"
    return
  else
    company.employees_number = doc.xpath("//td[@class='company-data-td']")[e_index].text.sub(/(名|人).+/,"").tr("０-９", "0-9").sub(/[^\d]+/, "").delete(",").to_i
  end

  company.save
  p company
  puts
end


urls = [
]

urls.each do |url|
  cp_scrape(Nokogiri::HTML.parse(open(url)))
  sleep 1
end
