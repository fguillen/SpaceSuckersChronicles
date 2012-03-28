require_relative "../../test_helper"

class FleetTest < Test::Unit::TestCase

  def setup
    super

    @universe    = S2C::Global.universe
    @planet      = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @destination = S2C::Models::Units::Planet.create!( :position => [1, 2] )
    @ship1       = S2C::Models::Units::Ship.create!( :base => @planet )
    @ship2       = S2C::Models::Units::Ship.create!( :base => @planet )

    @fleet =
      S2C::Models::Units::Fleet.arrange(
        :base   => @planet,
        :target => @destination,
        :ships  => [@ship1, @ship2]
      )
  end

  def test_setup
    assert_equal( false,            @fleet.id.nil? )
    assert_equal( @planet.id,       @fleet.base.id )
    assert_equal( @destination.id,  @fleet.target.id )
    assert_equal( 2,                @fleet.ships.size )
    assert_equal( @ship1.id,        @fleet.ships.first.id )
    assert_equal( @universe,        @fleet.universe )
    assert_equal( "fleet",          @fleet.name )
  end

  def test_start_trip
    @fleet.start_trip
    @fleet.reload

    assert_equal( @fleet, @fleet.job.unit )
    assert_equal( "travel", @fleet.job.name )
    assert_equal( 1, @fleet.job.ticks_total )
    assert_equal( 1, @fleet.job.ticks_remain )
  end

  def test_end_trip_when_planet_empty
    @fleet.expects( :conquer_planet )
    @fleet.end_trip
  end

  def test_end_trip_when_planet_not_empty
    @destination.ships.create!

    @fleet.expects( :combat_planet )
    @fleet.end_trip
  end

  def test_start_combat
    assert_difference "S2C::Models::Jobs::Combat.count", 1 do
      @fleet.start_combat
    end

    assert_equal( "combat",       @fleet.job.name )
    assert_equal( @fleet,         @fleet.job.unit )
    assert_equal( @destination,   @fleet.job.target )
    assert_equal( :end_combat,    @fleet.job.callback )
  end

  def test_end_combat_win
    @fleet.expects( :conquer_planet )
    @fleet.end_combat
  end

  def test_end_combat_lost
    @fleet.ships.destroy_all
    @fleet.expects( :surrender )
    @fleet.end_combat
  end

  def test_surrender
    assert_difference "S2C::Models::Units::Fleet.count", -1 do
      @fleet.surrender
    end
  end

  def test_conquer_planet
    assert_difference "S2C::Models::Units::Fleet.count", -1 do
      @fleet.conquer_planet
    end

    @destination.reload

    assert_equal( 2, @destination.ships.count )
  end
end