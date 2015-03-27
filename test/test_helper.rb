ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Add more helper methods to be used by all tests in this class...
class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end

# Helper methods for devise
class ActionController::TestCase
  include Devise::TestHelpers
end
