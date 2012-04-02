ENV["ENVIRONMENT"] = "test"

require "simplecov"
require "test/unit"
require "mocha"
require "ruby-debug"
require "delorean"
require "database_cleaner"

if( ENV["COVERAGE"] )
  SimpleCov.start do
    add_filter "/test/"
    command_name "test"
  end
end

require_relative "../lib/s2c"

S2C::Global.setup( File.expand_path( "#{File.dirname(__FILE__)}/fixtures/config.yml" ) )
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with( :truncation )

class Test::Unit::TestCase
  FIXTURES = File.expand_path( "#{File.dirname(__FILE__)}/fixtures" )

  def setup
    S2C::Logger.any_instance.stubs( :log )
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def assert_difference( expression, difference = 1 )
    before = eval( expression )
    yield
    after = eval( expression )
    assert_equal( before + difference, after )
  end
end