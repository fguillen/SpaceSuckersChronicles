require_relative '../test_helper'

class FleetTravelToEmptyPlanetTest < Test::Unit::TestCase

  def setup
    super

    S2C::Global.store.reset

    @universe   = S2C::Global.universe
    @planet1    = S2C::Global.store.create_planet( [1, 1] )
    @planet2    = S2C::Global.store.create_planet( [1, 3] )

    @ship1      = S2C::Global.store.create_ship( @planet1 )
    @ship2      = S2C::Global.store.create_ship( @planet1 )
    @ship3      = S2C::Global.store.create_ship( @planet1 )

    @ship1.stubs( :id ).returns( "ship1" )
    @ship2.stubs( :id ).returns( "ship2" )
    @ship3.stubs( :id ).returns( "ship3" )
  end

  def test_travel_to_empty_planet
    assert_equal( 5, @universe.units.size )
    assert_equal( 3, @planet1.units.size )
    assert_equal( 0, @planet2.units.size )

    fleet = S2C::Global.store.create_fleet( @planet1, @planet2, [@ship1, @ship2] )

    assert_equal( 6, @universe.units.size )
    assert_equal( 1, @planet1.units.size )
    assert_equal( 0, @planet2.units.size )
    assert_equal( 2, fleet.units.size )
    assert_equal( 2, fleet.job.ticks_remain )

    @universe.step
    assert_equal( 6, @universe.units.size )
    assert_equal( 1, @planet1.units.size )
    assert_equal( 0, @planet2.units.size )
    assert_equal( 2, fleet.units.size )
    assert_equal( 1, fleet.job.ticks_remain )

    @universe.step
    assert_equal( 5, @universe.units.size )
    assert_equal( 1, @planet1.units.size )
    assert_equal( 2, @planet2.units.size )
    assert_equal( 2, fleet.units.size )
    assert_equal( true, fleet.job.nil? )
  end

end