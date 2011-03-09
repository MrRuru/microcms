class AddImageToCmsContents < ActiveRecord::Migration
  def self.up
    add_column :cms_contents, :image_file_name,    :string
    add_column :cms_contents, :image_content_type, :string
    add_column :cms_contents, :image_file_size,    :integer
    add_column :cms_contents, :image_updated_at,   :datetime
  end

  def self.down
    remove_column :cms_contents, :image_file_name
    remove_column :cms_contents, :image_content_type
    remove_column :cms_contents, :image_file_size
    remove_column :cms_contents, :image_updated_at
  end
end
