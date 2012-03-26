require_relative '../test_helper'

class HangarBuildShipTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = S2C::Global.store.create_planet( [1, 1] )
    @parking    = S2C::Global.store.create_parking( @planet )
    @hangar     = S2C::Global.store.create_hangar( @planet )

    @parking.stubs( :id ).returns( "parking" )
    @hangar.stubs( :id ).returns( "hangar" )

    @hangar.stubs( :production_ticks ).returns( 2 )
  end

  def test_setup
    assert_equal( 3, @universe.units.size )
    assert_equal( nil, @hangar.job )
    assert_equal( 0, @hangar.building_ships.size )
    assert_equal( 0, @planet.units.size )
  end

  def test_build_ship
    @hangar.build_ship

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.units.size )
    assert_equal( 1, @hangar.building_ships.size )
    assert_equal( 2, @hangar.job.ticks_remain )

    @hangar.build_ship # adding a new ship to build
    @universe.step

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.units.size )
    assert_equal( 2, @hangar.building_ships.size )
    assert_equal( 1, @hangar.job.ticks_remain )


    @universe.step # finish one build, start next

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.units.size )
    assert_equal( 1, @hangar.building_ships.size )
    assert_equal( 2, @hangar.job.ticks_remain )

    @universe.step

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 4, @universe.units.size )
    assert_equal( 1, @planet.units.size )
    assert_equal( 1, @hangar.building_ships.size )
    assert_equal( 1, @hangar.job.ticks_remain )

    @universe.step # finish second ship

    assert_equal( true, @hangar.job.nil? )
    assert_equal( 5, @universe.units.size )
    assert_equal( 2, @planet.units.size )
    assert_equal( 0, @hangar.building_ships.size )
  end

  def test_no_add_ship_if_parking_full
    @parking.stubs( :capacity ).returns( 0 )

    @hangar.build_ship
    @universe.step

    assert( @hangar.job.instance_of?( S2C::Models::Jobs::BuildShip ) )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.units.size )
    assert_equal( 1, @hangar.building_ships.size )
    assert_equal( 1, @hangar.job.ticks_remain )

    @universe.step

    assert_equal( true, @hangar.job.nil? )
    assert_equal( 3, @universe.units.size )
    assert_equal( 0, @planet.units.size )
    assert_equal( 0, @hangar.building_ships.size )
  end

end