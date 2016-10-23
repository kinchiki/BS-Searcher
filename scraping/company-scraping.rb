require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require '../class/Company.rb'

url = 'https://job.rikunabi.com/2017/company/top/r716010091/'
doc = Nokogiri::HTML.parse(open(url))

company = Company.new

company.name = "hoge"
p company.name