class CmsPage < ActiveRecord::Base

  # Attributes
  attr_accessible :parent_page, 
                  :name,
                  :url,
                  :layout

  # Relations
  has_many :cms_contents, :foreign_key => "page_id"
  belongs_to :parent_page, :class_name => "CmsPage"
  # TODO : Not mandatory, handle removal
  
  # Validations
  validates :url, :format => { :with => /^([a-z]|[0-9]|-|_|\/)*$/ }
  validates :name, :presence => true, :uniqueness => true, :format => { :with => /^([a-z]|-|_)+$/ }
  # TODO : validate parent_page/url couple is unique


  # Recursive method to get all the content of a page. Can surely be optimized
  # Can also be better written ([list of contents].to_content_hash)
  def to_content(existing_contents = {})
    # Get the content for this page
    add_contents_to!(cms_contents, existing_contents)
    
    # Add the content of the parent page
    if parent_page
      return parent_page.to_content(existing_contents)
    # Or returns it merged with the global parameters
    else
      return add_contents_to!(CmsContent.global, existing_contents)
    end
  end
  
  def self.global_content
    return CmsContent.global.inject({}){ | acc, content | acc[content.name.to_sym] = content ; acc }
  end

  def to_s
    name
  end
  
  def url
    "/" + super.downcase
  end

  private 
  
  def add_contents_to!(source, dest)
    source.each do |cms_content|
      key = cms_content.name.to_sym
      dest[key] = cms_content unless dest.has_key?(key)
    end
    return dest
  end
    
end
