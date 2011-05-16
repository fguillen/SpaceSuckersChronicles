require_relative 'test_helper'

class ConfigTest < Test::Unit::TestCase
  def test_config
    config = S2C::Config.new( "#{FIXTURES_PATH}/config.yml" )
    
    assert_equal( 1, config['universe']['tick_seconds'] )
    assert_equal( 11, config['mine']['defense'] )
    assert_equal( 30, config['ship']['attack'] )
  end
end