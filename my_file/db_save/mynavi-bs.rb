require 'open-uri'

DOMAIN = "https://job.mynavi.jp"

def bs_scrape(doc, com)
  sleep 1
  bss = []

  locations = doc.xpath("//td[@class='area']")
  dates = doc.xpath("//td[@class='date']")
  times = doc.xpath("//td[@class='time']")

  (times.size).times do |i|
    next if dates[i].text == "上記以外の日程を希望"
    next unless times[i].text.size == 10 || times[i].text.size ==11

    bs = com.briefing_sessions.build

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

    check = BriefingSession.equal(bs.company_id, bs.location, bs.bs_date, bs.start_time, bs.finish_time).first
    if check.blank?
      # p bs
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

def get_company(c_name)
  com = Company.find_by(com_name: c_name)
  unless com.nil?
    com
  else
    false
  end
end

def save_url(bs_url)
  if Url.exists?(url_val: bs_url)
    Url.find_by(url_val: bs_url)
  else
    # createだと失敗してもオブジェクトが返るため真偽判定できない
    u = Url.new(url_val: bs_url, site_id: 2)
    if u.save
      u
    else
      false
    end
  end
end

def check_bs(bs)
  if bs.persisted?
    true
  else
    bs.save
  end
end

def save_data(bss, url)
  if u = save_url(url)
    bss.each do |bs|
      if check_bs(bs)
        p bs.briefing_session_urls.create(url_id: u.id) unless BriefingSessionUrl.exists?(briefing_session_id: bs.id, url_id: u.id)
      end
    end
  end
end


urls = [
]

urls.each do |base_url|
  doc = Nokogiri::HTML.parse(open(base_url))
  seminar_links = doc.xpath("//h3[@class='hdg01']/a")

  if seminar_links.empty?
    com = get_company(doc.xpath("//div[@class='inner']/h3").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, ''))
    bss = bs_scrape(doc, com) if com
    save_data(bss, base_url) unless bss.blank?
  else
    com = get_company(doc.xpath("//div[@class='heading2']/h2").text.gsub(/(\s|　|(\(株\))|\［.+］|【.+】|／.+|\[.+\]|\(.+\)|（.+）)+/, ''))
    get_bs_urls(seminar_links).each { |bs_url|
      bss = bs_scrape(Nokogiri::HTML.parse(open(bs_url)), com) if com
      save_data(bss, bs_url) unless bss.blank?
    }
  end
end
