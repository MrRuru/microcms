class AddUrlIndexToCmsPages < ActiveRecord::Migration
  def self.up
    add_index :cms_pages, :url
  end

  def self.down
    remove_index :cms_pages, :url
  end
end
