class ChangeBsAndUrl < ActiveRecord::Migration
  def change
    remove_foreign_key :urls, :briefing_session
    remove_reference :urls, :briefing_session, index: true
  end
end
