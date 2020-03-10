# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.2'

gem 'bcrypt'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails'
gem 'faker'
gem 'faraday'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails-i18n'
gem 'sendgrid-ruby'
gem 'slim-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 4.0'

group :development do
  gem 'byebug', platforms: %i[mri mingw x64_mingw], group: :test
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails', group: :test
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'factory_bot_rails', group: :development
  gem 'rspec-rails', group: :development
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
