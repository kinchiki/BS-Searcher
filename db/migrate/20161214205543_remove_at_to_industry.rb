class RemoveAtToIndustry < ActiveRecord::Migration
  def change
    remove_column :sub_industries, :created_at, :string
    remove_column :sub_industries, :updated_at, :string
    remove_column :main_industries, :created_at, :string
    remove_column :main_industries, :updated_at, :string
    add_index :sub_industries, :main_industry_id, name: "index_sub_industries_on_main_industry_id", using: :btree
  end
end
