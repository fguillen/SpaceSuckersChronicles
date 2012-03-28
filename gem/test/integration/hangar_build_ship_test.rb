require_relative '../test_helper'

class HangarBuildShipTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = @universe.planets.create!( :position => [1, 1] )
    @parking    = @planet.create_parking!
    @hangar     = @planet.create_hangar!
  end

  def test_setup
    assert_equal( 3,    @universe.units.size )
    assert_equal( nil,  @hangar.job )
    assert_equal( 0,    @hangar.building_ships )
    assert_equal( 0,    @planet.ships.size )
  end

  def test_build_ship
    @hangar.start_build_ship
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.ships.size )
    assert_equal( 1, @hangar.building_ships )
    assert_equal( 2, @hangar.job.ticks_remain )

    @hangar.start_build_ship # adding a new ship to build
    @universe.step
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.ships.size )
    assert_equal( 2, @hangar.building_ships )
    assert_equal( 1, @hangar.job.ticks_remain )


    @universe.step
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.ships.size )
    assert_equal( 2, @hangar.building_ships )
    assert_equal( 0, @hangar.job.ticks_remain )

    @universe.step # finish one build, start next
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.ships.size )
    assert_equal( 1, @hangar.building_ships )
    assert_equal( 2, @hangar.job.ticks_remain )

    @universe.step
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.ships.size )
    assert_equal( 1, @hangar.building_ships )
    assert_equal( 1, @hangar.job.ticks_remain )

    @universe.step
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.ships.size )
    assert_equal( 1, @hangar.building_ships )
    assert_equal( 0, @hangar.job.ticks_remain )

    @universe.step # finish second ship
    reload_units

    assert_equal( true, @hangar.job.nil? )
    assert_equal( 5, @universe.units.size )
    assert_equal( 2, @planet.ships.size )
    assert_equal( 0, @hangar.building_ships )
  end

  def test_no_add_ship_if_parking_full
    S2C::Models::Units::Parking.any_instance.stubs( :capacity ).returns( 1 )

    @hangar.start_build_ship
    @hangar.start_build_ship
    @hangar.start_build_ship
    @universe.step
    reload_units

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.ships.size )
    assert_equal( 3, @hangar.building_ships )
    assert_equal( 1, @hangar.job.ticks_remain )

    @universe.step
    @universe.step # first ship built, praking full removing build_ship jobs
    reload_units

    assert( @hangar.job.nil? )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.ships.size )
    assert_equal( 0, @hangar.building_ships )
  end

  def reload_units
    @universe.reload
    @planet.reload
    @parking.reload
    @hangar.reload
  end

end