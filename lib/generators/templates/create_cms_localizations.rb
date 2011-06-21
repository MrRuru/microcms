class CreateCmsLocalizations < ActiveRecord::Migration
  def self.up
    create_table :cms_localizations do |t|
      t.integer :cms_content_id
      t.string :locale
      t.text :content

      t.timestamps
    end
    add_index :cms_localizations, :cms_content_id
    add_index :cms_localizations, :locale
  end

  def self.down
    drop_table :cms_contents
  end
end
