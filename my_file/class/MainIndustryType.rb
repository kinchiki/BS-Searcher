class MainIndustryType
  attr_accessor :id, :type
  @@number = 1

  def initialize
    @id = @@number # 主業種id
    @type = "" # 主業種
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@type}"
  end
end
