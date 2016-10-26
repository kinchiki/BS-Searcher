class SubIndustryType
  attr_accessor :id, :main_type_id, :type
  @@number = 1

  def initialize
    @id = @@number # 副業種id
    @main_type_id = "" # メイン業種id
    @type = "" # 副業種
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@main_type_id},#{@type}"
  end
end
