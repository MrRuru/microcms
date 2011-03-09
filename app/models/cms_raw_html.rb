class CmsRawHtml < CmsContent

  # Attributes
  attr_accessible :content
  
  # Validations
  validates :content, :presence => true
  
  # Rendering
  def self.to_text
    "Raw HTML"
  end
    
  def to_s
    content
  end
  
end
