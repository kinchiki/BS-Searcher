class AddIndexs < ActiveRecord::Migration
  def change
    add_index :companies, :employees_number
    add_index :briefing_sessions, :location
    add_index :briefing_sessions, :bs_date
  end
end
