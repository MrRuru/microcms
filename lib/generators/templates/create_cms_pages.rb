class CreateCmsPages < ActiveRecord::Migration
  def self.up
    create_table :cms_pages do |t|
      t.integer :parent_page_id
      t.string :name
      t.string :url
      t.string :layout

      t.timestamps
    end  
    add_index :cms_pages, :name
    add_index :cms_pages, :url
  end

  def self.down
    drop_table :cms_pages
    remove_index :cms_pages, :name
    remove_index :cms_pages, :url
  end
end

