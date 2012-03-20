require_relative 'test_helper'

class UtilsTest < Test::Unit::TestCase
  def setup
    super
  end

  def test_planet_distance
    planet1 = S2C::Models::Planet.new( [0,0] )
    planet2 = S2C::Models::Planet.new( [0,0] )
    assert_equal( 0, S2C::Utils.planet_distance( planet1, planet2 ) )

    planet1 = S2C::Models::Planet.new( [0,0] )
    planet2 = S2C::Models::Planet.new( [1,1] )
    assert_equal( 1, S2C::Utils.planet_distance( planet1, planet2 ) )

    planet1 = S2C::Models::Planet.new( [0,0] )
    planet2 = S2C::Models::Planet.new( [5,5] )
    assert_equal( 7, S2C::Utils.planet_distance( planet1, planet2 ) )

    planet1 = S2C::Models::Planet.new( [0,0] )
    planet2 = S2C::Models::Planet.new( [5,10] )
    assert_equal( 11, S2C::Utils.planet_distance( planet1, planet2 ) )

    planet1 = S2C::Models::Planet.new( [10,5] )
    planet2 = S2C::Models::Planet.new( [0,0] )
    assert_equal( 11, S2C::Utils.planet_distance( planet1, planet2 ) )
  end

  def test_travel_ticks
    S2C::Utils.expects( :planet_distance ).returns( 1 )
    assert_equal( 1, S2C::Utils.travel_ticks( nil, nil, 1 ) )

    S2C::Utils.expects( :planet_distance ).returns( 8 )
    assert_equal( 4, S2C::Utils.travel_ticks( nil, nil, 2 ) )
  end

  def test_feed_universe
    universe = S2C::Universe.new
    S2C::Utils.feed_universe( universe )

    assert_equal( 12, universe.planets.size )
    assert_equal( 15, universe.ships.size )
    assert_equal( 1, universe.fleets.size )
  end

end