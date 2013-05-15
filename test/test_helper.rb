ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'active_support/testing/setup_and_teardown'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  class ActionDispatch::IntegrationTest
    include Rails.application.routes.url_helpers
    include Capybara::DSL
  end
  # Add more helper methods to be used by all tests here...
end
