require_relative "../../test_helper"

class HangarTest < Test::Unit::TestCase

  def setup
    super

    @planet   = S2C::Models::Units::Planet.create!
    @hangar   = S2C::Models::Units::Hangar.create!( :base => @planet )

    @planet.reload
  end

  def test_initialize
    assert_equal( @hangar,      @planet.hangar )
    assert_equal( @planet.id,   @hangar.base.id )
    assert_equal( 0,            @hangar.building_ships )
    assert_equal( true,         @hangar.job.nil? )
    assert_equal( 0,            @hangar.level )
    assert_equal( 100,          @hangar.production )
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
    @hangar.job = S2C::Models::Jobs::Upgrade.create( :unit => @hangar )

    assert_difference "S2C::Models::Jobs::Upgrade.count", -1 do
      @hangar.end_upgrade
    end

    @hangar.reload

    assert_equal( 1,  @hangar.level )
    assert_equal( 50, @hangar.production )
  end

  def test_build_ship
    @hangar.expects( :start_build_ship )
    @hangar.build_ship

    assert_equal( 1, @hangar.building_ships )
  end

  def test_start_build_ship
    assert_difference "S2C::Models::Jobs::BuildShip.count", 1 do
      @hangar.start_build_ship
    end

    @hangar.reload

    assert_equal( @hangar,          @hangar.job.unit )
    assert_equal( "build_ship",     @hangar.job.name )
    assert_equal( :end_build_ship,  @hangar.job.callback )
    assert_equal( 100,              @hangar.job.ticks_total )
    assert_equal( 100,              @hangar.job.ticks_remain )
  end

  def test_end_build_ship
    @hangar.job = S2C::Models::Jobs::BuildShip.create( :unit => @hangar )
    @hangar.building_ships = 1

    @hangar.expects( :start_build_ship ).never

    assert_difference "S2C::Models::Jobs::BuildShip.count", -1 do
      @hangar.end_build_ship
    end

    assert_equal( 0, @hangar.building_ships )
    assert_equal( 1, @planet.ships.count )
  end

  def test_end_build_ship_when_building_ships
    @hangar.job = S2C::Models::Jobs::BuildShip.create( :unit => @hangar )
    @hangar.building_ships = 2

    @hangar.expects( :start_build_ship )

    @hangar.end_build_ship
  end
end