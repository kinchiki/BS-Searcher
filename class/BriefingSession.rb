class BriefingSession
  attr_accessor :id, :company_id, :date, :start_time, :finish_time, :location
  @@number = 1

  def initialize
    @id = @@number # 説明会id
    @company_id = 0 # Company#id
    @date = "" # 開催日
    @start_time = "" # 開始時間
    @finish_time = "" # 終了時間
    @location = "" # 開催地
    #@deadline = "" # 受付締切
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@company_id},#{@date},#{@start_time},#{@finish_time},#{@location}"
  end

end
