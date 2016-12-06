class CreateBriefingSessions < ActiveRecord::Migration
  def change
    create_table :briefing_sessions do |t|
      t.belongs_to :company, foreign_key: true
      t.string :location, null: false, limit: 12
      t.date :bs_date, null: false
      t.time :start_time, null: false
      t.time :finish_time, null: false

      t.timestamps null: false
    end
  end
end
