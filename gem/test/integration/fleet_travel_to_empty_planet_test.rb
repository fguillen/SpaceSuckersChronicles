require_relative '../test_helper'

class FleetTravelToEmptyPlanetTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet1    = @universe.planets.create!( :position => [1, 1] )
    @planet2    = @universe.planets.create!( :position => [1, 3] )

    @ship1      = @planet1.ships.create!
    @ship2      = @planet1.ships.create!
    @ship3      = @planet1.ships.create!

    @fleet = nil
  end

  def test_setup
    assert_equal( 5, @universe.units.size )
    assert_equal( 0, @universe.fleets.size )
    assert_equal( 3, @planet1.ships.size )
    assert_equal( 0, @planet2.ships.size )
    assert_equal( 1000, @planet1.stuff )
  end

  def test_travel_to_empty_planet
    @fleet =
      S2C::Models::Units::Fleet.arrange(
        :base   => @planet1,
        :target => @planet2,
        :ships  => [@ship1, @ship2]
      )
    @fleet.start_trip
    reload_units

    assert_equal( "travel", @fleet.job.name )
    assert_equal( 6, @universe.units.size )
    assert_equal( 992, @planet1.stuff )
    assert_equal( 1, @planet1.ships.size )
    assert_equal( 0, @planet2.ships.size )
    assert_equal( 2, @fleet.ships.size )
    assert_equal( 2, @fleet.job.ticks_remain )

    @universe.step
    reload_units

    assert_equal( "travel", @fleet.job.name )
    assert_equal( 6, @universe.units.size )
    assert_equal( 1, @planet1.ships.size )
    assert_equal( 0, @planet2.ships.size )
    assert_equal( 2, @fleet.ships.size )
    assert_equal( 1, @fleet.job.ticks_remain )

    @universe.step
    reload_units

    assert_equal( "travel", @fleet.job.name )
    assert_equal( 6, @universe.units.size )
    assert_equal( 1, @planet1.ships.size )
    assert_equal( 0, @planet2.ships.size )
    assert_equal( 2, @fleet.ships.size )
    assert_equal( 0, @fleet.job.ticks_remain )

    @universe.step # conquer planet
    reload_units

    assert_equal( true, @fleet.job.nil? )
    assert_equal( 5, @universe.units.size )
    assert_equal( 1, @planet1.ships.size )
    assert_equal( 2, @planet2.ships.size )
    assert_equal( 0, @fleet.ships.size )
  end

  def reload_units
    @universe.reload
    @planet1.reload
    @planet2.reload
    @fleet.reload if S2C::Models::Units::Fleet.exists?( @fleet )
  end

end