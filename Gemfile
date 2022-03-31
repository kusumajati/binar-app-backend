# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'paranoia', '~> 2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'activerecord-nulldb-adapter'
gem 'groupdate'
gem 'pghero'
gem 'rollbar'

# set up enviroment to file
gem 'dotenv-rails'

# set up API grape and swagger doc
gem 'grape'
gem 'grape-entity'
gem 'grape-middleware-logger'
gem 'grape_on_rails_routes'
gem 'hashie-forbidden_attributes'

# documentation
gem 'grape-swagger'
gem 'grape-swagger-rails'

# user auth
gem 'devise'
gem 'doorkeeper'
gem 'oauth2'
gem 'wine_bouncer'

# worker
gem 'daemons'

# user storage handler
gem 'carrierwave'
gem 'delayed_job_active_record'

# pagination
gem 'api-pagination'
gem 'kaminari'

# api request
gem 'rest-client'

# dev tools
gem 'awesome_rails_console'
gem 'rename'
gem 'rubocop', require: false
gem 'rubocop-performance'

gem 'google-cloud-storage', '~> 1.11', require: false
gem 'image_processing', '~> 1.0'
gem 'parallel', '~> 1.19', '>= 1.19.1'
gem 'rack-cors'
