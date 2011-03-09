class CmsController < ApplicationController
  
  def show
    # Get the page
    @page = CmsPage.find_by_url(params[:page_url])

    # 404 if not found
    render :file => "public/404.html", :status => 404, :layout => false and return unless @page
    
    # Get the dynamic content
    @cms_page_content = @page.to_content

    # Render the corresponding view
    unless @page.layout.nil? || @page.layout.empty?
      render "cms/#{@page.name}", :layout => @page.layout
    else
      render "cms/#{@page.name}"
    end
  end

end
