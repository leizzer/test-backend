ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/rspec'
require 'capybara/webkit'

require_relative '../app'
require_relative '../api'
require_relative 'support/features_helper'
require_relative 'support/wait_for_ajax'

Capybara.app = TestApp

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FeaturesHelper
  config.include WaitForAjax

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
