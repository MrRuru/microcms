Rails.application.routes.draw do

  # CMS administration
  match 'cms_admin' => 'cms_admin/cms_pages#index'

  namespace 'cms_admin' do
    resources :cms_pages do
      resources :cms_contents, :only => [:create]
    end
    resources :cms_contents, :only => [:create, :destroy]
  end

  # Generic match
  match '/:page_url' => 'cms#show', :constraints => { :page_url => /([a-z]|[0-9]|-|_|\/)+/ }, :as => "cms_page"
  
end