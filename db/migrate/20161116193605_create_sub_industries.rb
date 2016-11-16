class CreateSubIndustries < ActiveRecord::Migration
  def change
    create_table :sub_industries do |t|
      t.belongs_to :main_industry, foreign_key: true
      t.string :sub_t, null: false, unique: true, limit: 100

      t.timestamps null: false
    end
  end
end
