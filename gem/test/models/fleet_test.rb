require_relative "../test_helper"

class FleetTest < Test::Unit::TestCase

  def setup
    @planet      = S2C::Models::Planet.new( [1, 1] )
    @destination = S2C::Models::Planet.new( [1, 2] )
    @ship1       = S2C::Models::Ship.new( @planet )
    @ship2       = S2C::Models::Ship.new( @planet )

    @fleet       = S2C::Models::Fleet.new( @planet, @destination, [@ship1, @ship2] )
  end

  def test_initialize
    assert_equal( false,            @fleet.id.nil? )
    assert_equal( @planet.id,       @fleet.planet.id )
    assert_equal( @destination.id,  @fleet.destination.id )
    assert_equal( 2,                @fleet.ships.size )
    assert_equal( @ship1.id,        @fleet.ships.first.id )
  end

  def test_start_trip
    S2C::Jobs::Travel.expects( :new ).with(
      :unit         => @fleet,
      :callback     => :end_trip,
      :destination  => @destination
    ).returns( "job" )

    @fleet.start_trip

    assert_equal( @fleet.id,  @fleet.ships.first.fleet.id )
    assert_equal( "job",      @fleet.job )
  end
end