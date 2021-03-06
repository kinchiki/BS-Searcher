require 'open-uri'

DOMAIN = "https://job.mynavi.jp"

def bs_scrape(doc, com_id, bs_url)
  sleep 1
  bss = []

  locations = doc.xpath("//td[@class='area']")
  dates = doc.xpath("//td[@class='date']")
  times = doc.xpath("//td[@class='time']")

  (times.size).times do |i|
    next if dates[i].text == "上記以外の日程を希望"
    next unless times[i].text.size == 10 || times[i].text.size ==11

    bs = bs_url.briefing_sessions.build
    bs.company_id = com_id

    loc = locations[i].text
    if loc == "東京"
      bs.location = "東京都"
    elsif loc == "大阪" || loc == "京都"
      bs.location = loc + "府"
    elsif loc == "北海道"
        bs.location = loc
    else
      bs.location = loc + "県"
    end

    bs.bs_date = dates[i].text[0..9]
    bs.start_time  = times[i].text[0..4].delete("～")
    bs.finish_time = times[i].text[-5..-1].delete("～")

    check = BriefingSession.equal(bs.company_id, bs.location, bs.bs_date, bs.start_time, bs.finish_time)
    if check.blank?
      # p bs
      bs.save
      bss << bs
    else
      # p check
      bss << check
    end
  end

  puts
  bss
end

def get_bs_urls(links)
  bs_urls = []
  links.each do |bs|
    bs_urls << DOMAIN + bs[:href]
  end
  bs_urls
end

def get_company_id(c_name)
  com = Company.find_by(com_name: c_name)
  unless com.nil?
    com.id
  else
    false
  end
end

def check_url(u)
  if Url.exists?(url_val: bs_url)
    url = Url.where(url_val: bs_url)
  else
    url = Url.new(url_val: bs_url, site_id: 2)
  end
end

def save_data(bss, url)
  p url
  if u.blank?
    u = Url.new(url_val: url, site_id: 2)
    if u.save
      bss.each do |bs|
        p u.briefing_session_urls.create(briefing_session_id: bs.id) if bs.present?
      end
    end
  # else
  #   bss.each do |bs|
  #     p BriefingSessionUrl.create(briefing_session_id: bs.id, url_id: u.id) if bs.id.present? && u.id.present?
  #   end
  end
  puts
end



urls = [
'https://job.mynavi.jp/17/pc/corp72425/sem.html',]

urls.each do |base_url|
  doc = Nokogiri::HTML.parse(open(base_url))
  seminar_links = doc.xpath("//h3[@class='hdg01']/a")

  if seminar_links.empty?
    com_id = get_company_id(doc.xpath("//div[@class='inner']/h3").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, ''))
    url = check_url(base_url)
    bss = bs_scrape(doc, com_id, url) if com_id
    save_data(bss, url) unless bss.blank?
  else
    com_id = get_company_id(doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, ''))
    get_bs_urls(seminar_links).each { |bs_url|
      url = check_url(bs_url)
      bss = bs_scrape(Nokogiri::HTML.parse(open(bs_url)), com_id, url) if com_id
      save_data(bss, url) unless bss.blank?
    }
  end
end
