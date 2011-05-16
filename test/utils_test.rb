require_relative 'test_helper'

class UtilsTest < Test::Unit::TestCase
  def setup
    S2C::Config.stubs( :config_path ).returns( "#{FIXTURES_PATH}/config.yml" )
  end
  
  def test_planet_distance
    universe = S2C::Universe.new( { 'size' => 20 } )

    planet1 = S2C::Models::Planet.new( universe, 'jupiter', [0,0] )
    planet2 = S2C::Models::Planet.new( universe, 'saturn', [0,0] )
    assert_equal( 0, S2C::Utils.planet_distance( planet1, planet2 ) )

    planet1 = S2C::Models::Planet.new( universe, 'jupiter', [0,0] )
    planet2 = S2C::Models::Planet.new( universe, 'saturn', [1,1] )
    assert_equal( 1, S2C::Utils.planet_distance( planet1, planet2 ) )
    
    planet1 = S2C::Models::Planet.new( universe, 'jupiter', [0,0] )
    planet2 = S2C::Models::Planet.new( universe, 'saturn', [5,5] )
    assert_equal( 7, S2C::Utils.planet_distance( planet1, planet2 ) )
    
    planet1 = S2C::Models::Planet.new( universe, 'jupiter', [0,0] )
    planet2 = S2C::Models::Planet.new( universe, 'saturn', [5,10] )
    assert_equal( 11, S2C::Utils.planet_distance( planet1, planet2 ) )
    
    planet1 = S2C::Models::Planet.new( universe, 'jupiter', [10,5] )
    planet2 = S2C::Models::Planet.new( universe, 'saturn', [0,0] )
    assert_equal( 11, S2C::Utils.planet_distance( planet1, planet2 ) )
  end
  
  def test_travel_black_stuff
    S2C::Utils.expects( :planet_distance ).returns( 1 )
    assert_equal( 2, S2C::Utils.travel_black_stuff( nil, nil ) )
    
    S2C::Utils.expects( :planet_distance ).returns( 2 )
    assert_equal( 4, S2C::Utils.travel_black_stuff( nil, nil ) )
  end
  
  def test_travel_ticks
    S2C::Utils.expects( :planet_distance ).returns( 1 )
    assert_equal( 1, S2C::Utils.travel_ticks( nil, nil, 1 ) )
    
    S2C::Utils.expects( :planet_distance ).returns( 8 )
    assert_equal( 4, S2C::Utils.travel_ticks( nil, nil, 2 ) )
  end
end