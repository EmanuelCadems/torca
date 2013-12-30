source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails',        '4.0.0'
gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder',     '~> 1.2'
gem 'figaro',       '0.7.0'

gem 'spree',             '2.1.3'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-1-stable'
gem 'spree_i18n',        github: 'spree/spree_i18n',        branch: '2-1-stable'
gem 'sinatra',           '1.4.4'
gem 'pg'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'rails-erd',    '1.1.0'
end

group :development, :test do
  gem 'rspec-rails',         github: 'rspec/rspec-rails', branch: 'records-in-rails-4'
  gem 'factory_girl_rails',  '4.2.1'
end

group :test do
  gem 'capybara',            '2.1.0'
  gem 'database_cleaner',    github: 'bmabey/database_cleaner'
  gem 'simplecov',           require: false
  gem 'launchy'
  gem 'webmock',             '1.16.1'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end
