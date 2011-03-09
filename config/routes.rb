Rails.application.routes.draw do

  # CMS administration
  namespace 'cms_admin' do
    resources :cms_pages do
      resources :cms_contents, :only => [:create]
    end
    resources :cms_contents
  end

  # Generic match
  match '/:page_url' => 'cms#show', :constraints => { :page_url => /([a-z]|[0-9]|-|_|\/)+/ }, :as => "cms_page"
  
end