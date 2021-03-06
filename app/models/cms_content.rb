class CmsContent < ActiveRecord::Base

  # Attributes
  attr_accessible :page_id, 
                  :name,
                  :type,
                  :contents
  
  # Relations
  belongs_to :page, :class_name => "CmsPage"
  has_many :cms_localizations, :autosave => true
  
  # Validations
  validates :name, :presence => true, :format => { :with => /^([a-z]|-|_)+$/ }
  validates_uniqueness_of :name, :scope => :page_id
  # validates :page, :presence => true
  # TODO : validate uniqueness of couple name x page
  
  # Scopes and queries
  scope :global, where(:page_id => nil).includes(:cms_localizations)
  scope :for_page, lambda{|page| where(:page_id => page.id).includes(:cms_localizations)}
  
  # Get/set the contents seamlessly in the linked database
  def contents=(contents_hash)
    # Create/set the cms_localizations
    contents_hash.each_pair do |language, content|
      existing_localization = CmsLocalization.find_by_cms_content_id_and_language(self.id, language)
      if existing_localization
        existing_localization.content = content
        throw "Error updating localization :#{existing_localization.errors}" unless existing_localization.save
      else
        cms_localizations.build(:language => language, :content => content)
      end 
    end    
  end
  
  def contents
    content_hash = Hash.new
    
    # Get the cms_localizations
    cms_localizations.each do |localization|
      content_hash[localization.language.to_sym] = localization.content
    end
    
    return content_hash
  end
  
  def localization(language)
    cms_localizations.find_by_language(language).content
  end
  
    
end
