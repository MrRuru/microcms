class CmsLocalization < ActiveRecord::Base

  # Attributes
  attr_accessible :content, :language
  
  # Relations
  belongs_to :cms_content
  
  # Validations
  validates_uniqueness_of :language, :scope => :cms_content_id
  validates_presence_of :language
  
  # Scopes and queries
  scope :global, where(:page_id => nil)
  scope :for_page, lambda{|page| where(:page_id => page.id)}
    
end
