source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.5"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
#Admin
gem 'devise'
gem 'activeadmin'
gem 'activeadmin_sidekiq_stats'
gem "chartkick", '~> 2.2.0'
gem 'groupdate'
gem 'sass-rails'
gem "octokit", "~> 5.0"
gem 'httparty'
gem 'nokogiri'
gem 'friendly_id', '~> 5.4.0'
gem 'watir'
gem 'tailwindcss-rails'
gem 'foreman'
gem 'mini_magick'
gem "escompress", "~> 0.3.0"

gem "dotenv"

group :development, :test do
  gem 'rspec-rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'database_cleaner'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'faker'
  gem 'cpf_faker'
  gem 'rubycritic', require: false
  gem 'simplecov'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rack-mini-profiler', require: false
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'rails_layout'
  gem 'letter_opener_web'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rspec-benchmark'
  gem 'database_cleaner'
end

