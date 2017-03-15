require 'database_cleaner'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

DatabaseCleaner.strategy = :transaction

module TestPlugin
  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end
end

module ActiveSupport
  class TestCase
    include TestPlugin
  end
end
