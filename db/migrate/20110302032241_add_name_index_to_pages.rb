class AddNameIndexToPages < ActiveRecord::Migration
  def self.up
    add_index :cms_pages, :name
  end

  def self.down
    remove_index :cms_pages, :name
  end
end
