class AddLayoutToCmsPages < ActiveRecord::Migration
  def self.up
    add_column :cms_pages, :layout, :string
  end

  def self.down
    remove_column :cms_pages, :layout
  end
end
