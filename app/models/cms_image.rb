class CmsImage < CmsContent

  # Attributes
  has_attached_file :image
  attr_accessible :image
  
  # Validations
  validates :image, :presence => true
    
  # Rendering
  def to_s
    content
  end
  
  def url
    image.url
  end
  
  def self.to_text
    "Uploaded image"
  end
  
end
