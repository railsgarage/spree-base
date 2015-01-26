ruby '2.2.0'

source 'https://rubygems.org'

gem 'rails', '>= 4.1.8'

gem 'pg'

gem 'spree', github: 'spree/spree'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'

# templates
gem 'slim'

# server
gem 'unicorn'
gem 'foreman'

# frontend
gem 'sass-rails', '~> 4.0.2'
gem 'coffee-rails'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha', :require => false
  gem 'simplecov', :require => false
  gem 'faker'
  gem 'vcr'
  gem 'webmock'
end

