require_relative 'test_helper'

class ConfigTest < Test::Unit::TestCase
  def test_config
    config = S2C::Config.new( "#{FIXTURES}/config.yml" )

    assert_equal( 1,  config['universe']['tick_seconds'] )
    assert_equal( 12, config['ship']['attack'] )
    assert_equal( 8,  config['ship']['defense'] )
  end
end