class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      #t.belongs_to :sub_industry, foreign_key: true
      t.string :name, null: false, unique: true, limit: 100
      t.string :head_office, null: false, limit: 30
      t.integer :employees_number, null: false

      t.timestamps null: false
    end
  end
end
