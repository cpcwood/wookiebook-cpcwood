require 'database_cleaner/active_record'
require 'simplecov'
require 'simplecov-console'
require 'rails_helper'
require 'webdrivers'

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless

DatabaseCleaner.strategy = :transaction

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
  # below excluded until better understanding of directories gained
  add_filter '/app/assets/'
  add_filter '/app/channels/'
  add_filter '/app/jobs/'
  add_filter '/app/mailers/'
  add_filter '/app/helpers/'
end

RSpec.configure do |config|
  config.before(:all) do
    User.create(id: 0, email: '.', password: '.', planet: 'Galaxy').save(validate: false)
  end

  config.before(:each) do
    # data is not saved into real Redis but you still need to clear it
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    User.destroy_all
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on a real object.
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation

  config.after(:suite) do
    puts
  end
end
