ruby '2.1.2'

source 'https://rubygems.org'

gem 'cancan'
gem 'coffee-rails', '~> 4.0.0'
gem 'foundation-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg'
gem 'rails', '4.1.5'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier'
gem 'wicked_pdf'

group :production do
  gem 'wkhtmltopdf-heroku'
end

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'quiet_assets'
  gem 'rspec-rails'
end
