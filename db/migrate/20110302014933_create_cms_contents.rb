class CreateCmsContents < ActiveRecord::Migration
  def self.up
    create_table :cms_contents do |t|
      t.integer :page_id
      t.string :name
      t.string :type

      t.timestamps
    end
    add_index :cms_contents, :page_id
  end

  def self.down
    drop_table :cms_contents
  end
end
