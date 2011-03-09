class CmsAdmin::CmsContentsController < CmsAdmin::CmsAdminController


  def create
    @content = params[:type].constantize.new(params[:content])
    @content.page_id = params[:cms_page_id]
    if @content.save
      flash[:notice] = "Content created."
    else
      flash[:error] = "The content couldn't be created:\n#{@content.errors.full_messages.join('\n')}"
    end
    redirect_to request.referer || cms_admin_cms_pages_path
  end 
  

  def update
    @content = CmsContent.find params[:id]
    if @content.update_attributes(params[@content.class.name.underscore.to_sym])
      flash[:notice] = "Content successfully updated"
    else
      flash[:error] = "Content couldn\'t be updated:\n#{@page.errors.full_messages.join('\n')}"
    end
    redirect_to request.referer || cms_admin_cms_pages_path
  end  
  
  def destroy
    @content = CmsContent.find params[:id]
    unless @content.destroy
      flash[:error] = "The content couldn't be deleted."
    end
    redirect_to request.referer || cms_admin_cms_pages_path
  end  
end