class BriefingSession
  attr_accessor :id, :company_id, :date, :start_time, :finish_time, :location
  @@number = 1

  def initialize(n,m)
    @id = @@number # 説明会id
    @company_id = m # Company#id
    @date = [] # 開催日
    @start_time = [] # 開始時間
    @finish_time = [] # 終了時間
    #@deadline = [] # 受付締切
    @location = [] # 開催地
    @@number += 1
    #@company_name = "" # 企業名
    #@main_type = "" # メイン業種
    #@sub_type = "" # サブ業種
  end

  def show_company
     puts @id+","+@company_name+","+@main_type+","+@sub_type
  end

  def show_data
    (date.size).times do |i|
      puts @date[i]+","+@start_time[i]+","+@finish_time[i]+","+@deadline[i]+","+@location[i]
    end
  end

end
