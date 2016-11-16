class AddSiteToUrls < ActiveRecord::Migration
  def change
    add_reference :urls, :site, index: true, foreign_key: true
    change_column :urls, :url_v, :string, limit: 500
    rename_column :urls, :url_v, :url_val
  end
end
