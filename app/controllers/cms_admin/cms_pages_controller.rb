class CmsAdmin::CmsPagesController < CmsAdmin::CmsAdminController

  before_filter :load_page

  def index
    @contents = CmsContent.global
  end
  
  def edit
    @page = CmsPage.find params[:id]
    @contents = @page.to_content.values
  end

  # POST
  def create
    @page = CmsPage.new(params[:cms_page])
    if @page.save
      flash[:notice] = "Page successfully created"
      redirect_to edit_cms_admin_cms_page_url(@page)
    else
      flash[:error] = "Page couldn\'t be created:\n#{@page.errors.full_messages.join('\n')}"
      redirect_to request.referer || cms_admin_cms_pages_url
    end
  end

  # PUT
  def update
    @page = CmsPage.find(params[:id])
    if @page.update_attributes(params[:cms_page])
      flash[:notice] = "Page successfully updated"
    else
      flash[:error] = "Page couldn\'t be updated:\n#{@page.errors.full_messages.join('\n')}"
    end
    redirect_to edit_cms_admin_cms_page_url(@page)
  end
  
  # DELETE
  def destroy
    @page = CmsPage.find(params[:id])
    @page.destroy
    flash[:notice] = "Page successfully deleted"
    redirect_to cms_admin_cms_pages_url
  end
  
  private
  
  def load_page
    @pages = CmsPage.all
    @new_page = CmsPage.new
    @new_content = CmsContent.new
  end
end