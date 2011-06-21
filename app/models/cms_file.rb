class CmsFile < ActiveRecord::Base
  # Attributes
  has_attached_file :file
  attr_accessible :file
  
  # Validations
  validates :file, :presence => true
end