class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_name, null: false, unique: true, limit: 30

      t.timestamps null: false
    end
  end
end
