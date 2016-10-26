class Company
  attr_accessor :id, :name, :main_type, :sub_type, :employees_number, :head_office
  @@number = 1

  def initialize(n=0)
    @id = @@number # 企業id
    @sub_type_id = n # 副業種id
    @name = "" # 企業名
    @head_office = "" # 本社所在地
    @employees_number = 1 # 従業員数
    # @main_type = "" # 主業種
    @@number += 1
  end

  def show_data
    puts "#{@id},#{@name},#{@sub_type},#{@head_office},#{@employees_number}"
  end
end
