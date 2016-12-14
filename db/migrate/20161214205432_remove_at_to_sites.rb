class RemoveAtToSites < ActiveRecord::Migration
  def change
    remove_column :sites, :created_at, :string
    remove_column :sites, :updated_at, :string
  end
end
