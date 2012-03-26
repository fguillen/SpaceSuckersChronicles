ENV["ENVIRONMENT"] = "test"

require 'simplecov'
require 'test/unit'
require 'mocha'
require 'ruby-debug'
require 'delorean'
require "database_cleaner"

SimpleCov.start do
  add_filter "/test/"
  command_name "test"
end

require_relative '../lib/s2c'


DatabaseCleaner.strategy = :transaction

class Test::Unit::TestCase
  FIXTURES = File.expand_path("#{File.dirname(__FILE__)}/fixtures")

  def setup
    DatabaseCleaner.start
    S2C::Logger.any_instance.stubs( :log )
    S2C::Global.setup( "#{FIXTURES}/config.yml" );
  end

  def teardown
    DatabaseCleaner.clean
  end
end