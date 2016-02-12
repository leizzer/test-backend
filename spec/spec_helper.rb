ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/rspec'
require 'headless'

require_relative '../app'
require_relative '../api'
require_relative 'features/features_helper.rb'

Capybara.app = TestApp

headless = Headless.new
headless.start

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FeaturesHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
