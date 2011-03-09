class CmsContent < ActiveRecord::Base

  # Constants
  SUBCLASSES= ["CmsFormattedText","CmsImage","CmsRawHtml"] # Dirty, but the subclasses have trouble being loaded in a controller action

  # Attributes
  attr_accessible :page_id, 
                  :name,
                  :type
  
  # Relations
  belongs_to :page, :class_name => "CmsPage"
  
  # Validations
  validates :name, :presence => true, :format => { :with => /^([a-z]|-|_)+$/ }
  # validates :page, :presence => true
  # TODO : validate uniqueness of couple name x page
  
  # Scopes and queries
  scope :global, where(:page_id => nil)
  scope :for_page, lambda{|page| where(:page_id => page.id)}
  
  # Methods
  def self.one_of_each(page = nil)
    each = []
    # Solution : create one of each...
    subclasses.each do |subclass|
      each << subclass.new(:page => page)
    end
    return each
  end
  
  def self.subclasses
    return SUBCLASSES.map{ |c| c.constantize }
  end

  def self.class_name
    name[3..-1].underscore
  end
    
  def class_name
    self.class.class_name
  end
  
end
