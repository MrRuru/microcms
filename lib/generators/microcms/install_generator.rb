module Microcms
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)
      
      desc 'Copy the migrations and assets'

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_assets
        puts "Copying ckeditor files to public/javascripts/ckeditor"
        FileUtils.cp_r File.expand_path("../../../../public/javascripts/ckeditor/", __FILE__), "vendor/javascripts/"

        puts "Copying css files to public/stylesheets/cms_admin"
        ["cms_admin", "base", "layout", "skeleton"].each do |css_file|
          copy_file "../../../public/stylesheets/#{css_file}.css", "vendor/stylesheets/cms_admin/#{css_file}.css"
        end

        puts "Copying js files to public/javascripts/cms_admin"
        ["cms_admin", "jquery.min", "rails", "tabs"].each do |js_file|
          copy_file "../../../public/javascripts/#{js_file}.js", "vendor/javascripts/cms_admin/#{js_file}.js"
        end        
        
        puts "Copying configuration initializers to config/initializers"
        copy_file "config/initializer.rb" "config/initializers/microcms.rb"
      end

      def copy_migrations
        ["create_cms_pages", "create_cms_contents", "create_cms_files", "create_cms_localizations"].each do |migration_file|
          migration_template "migrations/#{migration_file}.rb", "db/migrate/#{migration_file}.rb"
        end
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
