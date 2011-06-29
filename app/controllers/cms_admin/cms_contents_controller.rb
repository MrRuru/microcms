class CmsAdmin::CmsContentsController < CmsAdmin::CmsAdminController

  # Only action for create and update
  def create
    @content = CmsContent.find params[:id] if params[:id]
    
    if @content
      @content.attributes = params[:cms_content]
    else
      @content = CmsContent.new(params[:cms_content].merge(:page_id => params[:cms_page_id]))
    end
      
    if @content.save
      flash[:notice] = "Content successfully saved."
    else
      flash[:error] = "The content couldn't be saved:\n#{@content.errors.full_messages.join('\n')}"
    end
    redirect_to request.referer || cms_admin_cms_pages_path
  end
  
  def destroy
    @content = CmsContent.find params[:id]
    unless @content.destroy
      flash[:error] = "The content couldn't be deleted."
    end
    redirect_to request.referer || cms_admin_cms_pages_path
  end  
end