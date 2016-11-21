class BriefingSession
  attr_accessor :id, :company_id, :bs_date, :start_time, :finish_time, :location
  #@@number = 1

  def initialize
    #@id = @@number # 説明会id
    @company_id = 0 # Company#id
    @location = "" # 開催地
    @bs_date = "" # 開催日
    @start_time = "" # 開始時間
    @finish_time = "" # 終了時間
    #@@number += 1
  end

  def show_data
    puts "#{@company_id},#{@location},#{@bs_date},#{@start_time},#{@finish_time}"
  end
end
