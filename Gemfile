ruby '2.3.0'

source 'https://rubygems.org'

gem 'rails', '4.2.5.2'

gem 'bcrypt', '~> 3.1.7'
gem 'cancan'
gem 'coffee-rails'
gem 'foundation-rails'
gem 'foundation-icons-sass-rails'
gem 'haml-rails'
gem 'handlebars_assets'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'omniauth'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'omniauth-linkedin-oauth2'
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
