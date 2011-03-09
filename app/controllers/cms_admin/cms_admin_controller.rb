class CmsAdmin::CmsAdminController < ApplicationController
  layout "cms_admin"
  before_filter :cms_check_authentication
  
  private
  
  def cms_check_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end
end