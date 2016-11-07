require 'bundler/setup'
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML::parse(open('data/html/rikinabi_company.html'))

main_type = doc.xpath("//td[@class='company-information-detail']")[0]
# sub_type = doc.xpath("//span[@class='u-db u-fs14']").text

employees_number = doc.xpath("//td[@class='company-data-td']")
# employees_number.each { |e|
#   p e.text
#   puts
# }
# puts

tmp = doc.xpath("//th[@class='company-data-th']")
p tmp.text
puts

p tmp[tmp.text.index("従業員数")]
# tmp.each_with_index { |node, i|
#   if node.text == "従業員数"
#     break
#   end
# }
puts


n = employees_number[3].text.sub(/名.+/,"").sub(/[^\d]+/, "").delete(",").to_i
p n
puts

main_type.children.each { |e| p e.text  }
puts


# #<Nokogiri::XML::Element:0x3ffe34569dbc name="th" attributes=[#<Nokogiri::XML::Attr:0x3ffe34569d44 name="class" value="company-data-th">] children=[#<Nokogiri::XML::Element:0x3ffe345697b8 name="span" attributes=[#<Nokogiri::XML::Attr:0x3ffe345696f0 name="id" value="03000003584462">]>, #<Nokogiri::XML::Text:0x3ffe345691c8 "従業員数">]>
