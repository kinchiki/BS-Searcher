class CreateMainIndustries < ActiveRecord::Migration
  def change
    create_table :main_industries do |t|
      t.string :main_t, null: false, unique: true, limit: 20

      t.timestamps null: false
    end
  end
end
