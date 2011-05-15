require_relative 'test_helper'

class ConfigTest < Test::Unit::TestCase
  def test_config
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
    
    assert_equal( 1, S2C::Config.config['universe']['tick_seconds'] )
    assert_equal( 11, S2C::Config.config['mine']['defense'] )
    assert_equal( 30, S2C::Config.config['ship']['attack'] )
  end
end