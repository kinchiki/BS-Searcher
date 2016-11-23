class Company
  attr_accessor :name, :employees_number, :head_office, :sub_str #:id, :sub_industry_id,
  @@number = 1

  def initialize(n=10)
    #@id = @@number # 企業id
    @sub_industry_id = n # 副業種id
    @name = "" # 企業名
    @head_office = "" # 本社所在地
    @employees_number = 1 # 従業員数
    @sub_str = ""
    #@@number += 1
  end

  def show_data
    puts "#{@name}, #{@head_office}, #{@employees_number}, #{@sub_str}"
  end
end
