require 'test/unit'
require 'mocha'
require 'ruby-debug'
require 'delorean'

require_relative '../lib/s2c'

class Test::Unit::TestCase
  FIXTURES = File.expand_path("#{File.dirname(__FILE__)}/fixtures")

  def setup
    S2C::Logger.any_instance.stubs( :log )
  end
end