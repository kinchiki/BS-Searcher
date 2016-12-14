class AddIndexReferences < ActiveRecord::Migration
  def change
    add_index :briefing_sessions, :company_id, name: "index_briefing_sessions_on_company_id", using: :btree
  end
end
