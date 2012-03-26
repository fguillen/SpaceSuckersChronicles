require_relative "../test_helper"

class FleetTest < Test::Unit::TestCase

  def setup
    super

    @planet      = S2C::Models::Units::Planet.create( :position => [1, 1] )
    @destination = S2C::Models::Units::Planet.create( :position => [1, 2] )
    @ship1       = S2C::Models::Units::Ship.create( :base => @planet )
    @ship2       = S2C::Models::Units::Ship.create( :base => @planet )

    @fleet =
      S2C::Models::Units::Fleet.arrange(
        :base   => @planet,
        :target => @destination,
        :ships  => [@ship1, @ship2]
      )
  end

  def test_initialize
    assert_equal( false,            @fleet.id.nil? )
    assert_equal( @planet.id,       @fleet.base.id )
    assert_equal( @destination.id,  @fleet.target.id )
    assert_equal( 2,                @fleet.units.size )
    assert_equal( @ship1.id,        @fleet.units.first.id )
  end

  def test_start_trip
    @fleet.start_trip
    @fleet.reload

    assert_equal( "job",      @fleet.job )
  end
end