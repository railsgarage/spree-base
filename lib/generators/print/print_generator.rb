class PrintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :new_app_name, type: :string, default: 'blue_print'

  def rename
    root = Rails.root
    files = [File.expand_path('Rakefile', root),File.expand_path('Readme.md', root),File.expand_path('config.ru', root),File.expand_path('config/application.rb', root),File.expand_path('config/database.yml', root),File.expand_path('config/environment.rb', root),File.expand_path('config/environments/test.rb', root),File.expand_path('config/environments/development.rb', root),File.expand_path('config/environments/production.rb', root),File.expand_path('config/initializers/session_store.rb', root),File.expand_path('config/initializers/secret_token.rb', root),File.expand_path('config/routes.rb', root)]
    puts 'Changing names in files.'
    files.each do |path|
      file = File.read(path)
      new_file = file.gsub(/(classie|Classie)/) do |match|
        case match
        when 'classie'
          new_app_name
        when 'Classie'
          new_app_name.camelize
        end
      end
      File.open(path, 'w') { |file| file.puts new_file }
    end
    puts 'Names all changed'
  end
end
