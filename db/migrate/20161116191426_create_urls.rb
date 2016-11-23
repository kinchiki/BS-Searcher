class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.belongs_to :briefing_session, foreign_key: true
      #t.belongs_to :site, foreign_key: true
      t.string :url_v, null: false, unique: true, limit: 255

      t.timestamps null: false
    end
  end
end
