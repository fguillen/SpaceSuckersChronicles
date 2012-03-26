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

    puts "XXX: @planet: #{@planet.id}"
    puts "XXX: @planet.base: #{@planet.base_id}"
    puts "XXX: @destination: #{@destination.id}"
    puts "XXX: @ship1: #{@ship1.id}"
    puts "XXX: @ship2: #{@ship2.id}"
    puts "XXX: @fleet: #{@fleet.id}"
  end

  def test_initialize
    puts "XXX: @fleet: #{@fleet.id}"
    puts "XXX: @fleet.units: #{@fleet.units}"

    assert_equal( false,            @fleet.id.nil? )
    assert_equal( @planet.id,       @fleet.base.id )
    assert_equal( @destination.id,  @fleet.target.id )
    assert_equal( 2,                @fleet.units.size )
    assert_equal( @ship1.id,        @fleet.units.first.id )
  end

  def test_start_trip
    S2C::Models::Jobs::Travel.expects( :new ).with(
      :unit         => @fleet,
      :callback     => :end_trip,
      :destination  => @destination
    ).returns( "job" )

    @fleet.start_trip

    assert_equal( "job",      @fleet.job )
  end
end