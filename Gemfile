ruby '2.1.2'

source 'https://rubygems.org'

gem 'rails', '4.1.6'

gem 'bcrypt', '~> 3.1.7'
gem 'cancan'
gem 'coffee-rails', '~> 4.0.0'
gem 'foundation-rails'
gem 'foundation-icons-sass-rails'
gem 'haml-rails'
gem 'handlebars_assets'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'omniauth'
gem 'pg'
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
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring'
end

group :development, :test do
  gem 'pry'
  gem 'quiet_assets'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: true
end
