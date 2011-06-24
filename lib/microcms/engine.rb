require 'microcms/application_helper.rb'

module Microcms
  class Engine < Rails::Engine
    initializer 'microcms.helper' do |app|
      ActionView::Base.send :include, Microcms::ApplicationHelper
    end
  end

  # Config block (to use with initializers)
  def self.config(&block)
    @@config ||= Microcms::Engine::Configuration.new

    yield @@config if block

    return @@config
  end
end