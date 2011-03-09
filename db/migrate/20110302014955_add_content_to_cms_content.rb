class AddContentToCmsContent < ActiveRecord::Migration
  def self.up
    add_column :cms_contents, :content, :string
  end

  def self.down
    remove_column :cms_contents, :content
  end
end
