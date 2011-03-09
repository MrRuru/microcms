require 'rdiscount'

class CmsFormattedText < CmsContent

  # Attributes
  attr_accessible :content
  
  # Validations
  validates :content, :presence => true
  
  # Rendering
  def self.to_text
    "Formatted text"
  end
    
  def to_s
    content
  end
  
  def to_html
    RDiscount.new(content).to_html
  end
  
end
