require 'microcms/application_helper.rb'

module Microcms
  class Engine < Rails::Engine
    initializer 'microcms.helper' do |app|
      ActionView::Base.send :include, Microcms::ApplicationHelper
    end
  end
end