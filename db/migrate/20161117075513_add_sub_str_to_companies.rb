class AddSubStrToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sub_str, :string, limit: 100
  end
end
