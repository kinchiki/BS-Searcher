class Company
  @@number = 1

  def initialize(n)
    @id = @@number # 企業id
    @name = "" # 企業名
    @main_type = "" # メイン業種
    @sub_type = "" # サブ業種
    @employees_number = n # 従業員数
    @head_office = "" # 本社所在地
    @@number += 1
  end

end
