module Microcms
  module ApplicationHelper

    # Load the cms of a page
    def load_cms(page_name = nil)
      if page_name
        name = page_name.to_s
        page = CmsPage.find_by_name(name)
        throw "Cms page \"#{page_name}\" not found!" unless page
      end

      if page
        @cms_page_content = page.to_content
      else
        @cms_page_content = CmsPage.global_content      
      end
    end


    # The raw content. Maybe should be using only specific helpers, but this one is so small...
    def cms(name, locale = I18n.locale)
      return "Content not loaded" unless @cms_page_content
    
      if @cms_page_content.has_key?(name.to_sym)
        raw @cms_page_content[name.to_sym].localization(locale)
      else
        "Content not found for #{key}"
      end
    end
  
    # Link to semi-static page
    def cms_link_to(text, page_name, options={})
      return "Content not loaded" unless @cms_page_content

      name = page_name.to_s
      page = CmsPage.find_by_name(name)

      if page
        link_to text, page.url, options
      else
        "Link not found for #{name}"
      end
    end
  
  end
end