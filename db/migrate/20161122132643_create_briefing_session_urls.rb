class CreateBriefingSessionUrls < ActiveRecord::Migration
  def change
    create_table :briefing_session_urls do |t|
      t.references :briefing_session, index: true, foreign_key: true
      t.references :url, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
