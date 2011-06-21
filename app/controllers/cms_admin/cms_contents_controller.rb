class CmsAdmin::CmsContentsController < CmsAdmin::CmsAdminController

  # Only action for create and update
  def create
    @content = CmsContent.find params[:id]
    @content ||= CmsContent.new(:page_id => params[:cms_page_id])
  
    @content.attributes = params[:cms_content]
    @content.contents = params[:cms_content][:contents]
    
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