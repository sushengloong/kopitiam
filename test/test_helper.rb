ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'active_support/testing/setup_and_teardown'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  class ActionDispatch::IntegrationTest
    # make routes available in integration tests
    include Rails.application.routes.url_helpers
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL
  end
  # Add more helper methods to be used by all tests here...
end
