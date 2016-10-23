class Company
  attr_accessor :id, :name, :main_type, :sub_type, :employees_number, :head_office
  @@number = 1

  def initialize
    @id = @@number # 企業id
    @name = "" # 企業名
    @main_type = "" # メイン業種
    @sub_type = "" # サブ業種
    @employees_number = 0 # 従業員数
    @head_office = "" # 本社所在地
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@name},#{@main_type},#{sub_type},#{@employees_number},#{@head_office}"
  end

end
