require_relative "../../test_helper"

class HangarTest < Test::Unit::TestCase

  def setup
    super

    @planet   = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @hangar   = @planet.create_hangar!
    @parking  = @planet.create_parking!

    @planet.reload
  end

  def test_initialize
    assert_equal( @hangar,      @planet.hangar )
    assert_equal( @planet.id,   @hangar.base.id )
    assert_equal( 0,            @hangar.building_ships )
    assert_equal( true,         @hangar.job.nil? )
    assert_equal( 0,            @hangar.level )
    assert_equal( 2,            @hangar.production )
    assert_equal( "hangar",     @hangar.name )
    assert_equal( 0,            @planet.ships.count )
  end

  def test_start_upgrade
    assert_difference "S2C::Models::Jobs::Upgrade.count", 1 do
      @hangar.start_upgrade
    end

    @hangar.reload

    assert_equal( @hangar,      @hangar.job.unit )
    assert_equal( "upgrade",    @hangar.job.name )
    assert_equal( :end_upgrade, @hangar.job.callback )
    assert_equal( 1,            @hangar.job.ticks_total )
    assert_equal( 1,            @hangar.job.ticks_remain )
  end

  def test_end_upgrade
    @hangar.end_upgrade
    @hangar.reload

    assert_equal( 1,  @hangar.level )
    assert_equal( 1,  @hangar.production )
  end

  def test_start_build_ship
    assert_difference "S2C::Models::Jobs::BuildShip.count", 1 do
      @hangar.start_build_ship
    end

    @hangar.reload

    assert_equal( @hangar,          @hangar.job.unit )
    assert_equal( "build_ship",     @hangar.job.name )
    assert_equal( :end_build_ship,  @hangar.job.callback )
    assert_equal( 2,                @hangar.job.ticks_total )
    assert_equal( 2,                @hangar.job.ticks_remain )
  end

  def test_end_build_ship
    @hangar.end_build_ship

    assert_equal( 0, @hangar.building_ships )
    assert_equal( 1, @planet.ships.count )
  end

  def test_end_build_ship_when_parking_full
    S2C::Models::Units::Parking.any_instance.stubs( :full? ).returns( true )

    @hangar.start_build_ship
    @hangar.start_build_ship

    assert_equal( 2, @hangar.building_ships )

    @hangar.end_build_ship

    assert_equal( 0, @hangar.building_ships )
    assert_equal( 0, @planet.ships.count )
  end
end