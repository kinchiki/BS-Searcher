class AddSubIndustryToCompanies < ActiveRecord::Migration
  def change
    add_reference :companies, :sub_industry, index: true, foreign_key: true

    rename_column :companies, :name, :com_name
  end
end
