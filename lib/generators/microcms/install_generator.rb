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
        FileUtils.cp_r File.expand_path("../../../../public/javascripts/ckeditor/", __FILE__), "public/javascripts/"
        copy_file "../../../public/javascripts/cms_admin.js", "public/javascripts/cms_admin.js"
        copy_file "../../../public/stylesheets/cms_admin.css", "public/stylesheets/cms_admin.css"
      end

      def copy_migrations
        ["create_cms_pages", "create_cms_contents", "create_cms_files", "create_cms_localizations"].each do |migration_file|
          migration_template "#{migration_file}.rb", "db/migrate/#{migration_file}.rb"
        end
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
