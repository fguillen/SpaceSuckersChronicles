require_relative 'test_helper'

class ConstructionTest < Test::Unit::TestCase
  def setup 
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
    S2C::Universe.stubs( :log )
  end
  
  def test_initialize
    construction = S2C::Models::Construction.new( 'jupiter', 'mine' )
    assert_equal( 0, construction.level )
    assert_equal( :under_construction, construction.status )
    assert_equal( 'jupiter', construction.planet )
    assert_equal( 'mine', construction.type )
  end
  
  def test_upgrade
    planet = S2C::Models::Planet.new( 'jupiter' )
    planet.expects( :black_stuff ).returns( 14 )
    planet.expects( :remove_black_stuff ).with( 14 )
    
    construction = S2C::Models::Construction.new( planet, 'mine' )
    construction.instance_variable_set( :@status, :standby )
    
    construction.upgrade
    assert_equal( 0, construction.level )
    assert_equal( :upgrading, construction.status )
  end
  
  def test_attack_calculation_for_mine
    construction = S2C::Models::Construction.new( 'jupiter', 'mine' )
    assert_equal( 10, construction.attack )
    
    construction.instance_variable_set( :@level, 1 )
    assert_equal( 21, construction.attack )
    
    construction.instance_variable_set( :@level, 2 )
    assert_equal( 34, construction.attack )
    
    construction.instance_variable_set( :@level, 3 )
    assert_equal( 50, construction.attack )
    
    construction.instance_variable_set( :@level, 4 )
    assert_equal( 69, construction.attack )
  end
  
  def test_defense_calculation_for_mine
    construction = S2C::Models::Construction.new( 'jupiter', 'mine' )
    assert_equal( 11, construction.defense )
    
    construction.instance_variable_set( :@level, 1 )
    assert_equal( 23, construction.defense )
  end
  
  def test_attack_calculation_for_garage
    construction = S2C::Models::Construction.new( 'jupiter', 'garage' )
    assert_equal( 20, construction.attack )
    
    construction.instance_variable_set( :@level, 1 )
    assert_equal( 42, construction.attack )
  end
end