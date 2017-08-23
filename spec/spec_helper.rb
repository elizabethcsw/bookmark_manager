ENV['RACK_ENV'] = 'test'

require 'simplecov'
require 'simplecov-console'
require 'capybara/rspec'
require 'data_mapper'
require 'dm-postgres-adapter'
require './app/models/link.rb'
require 'database_cleaner'

# require 'capybara'
# require 'rspec'
require_relative '../app/app.rb'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

Capybara.app = BookmarkManager

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Everything in this block runs once before each individual test
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Everything in this block runs once after each individual test
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end

end
