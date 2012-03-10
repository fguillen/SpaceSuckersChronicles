require_relative 'test_helper'

class FleetTest < Test::Unit::TestCase

  def setup
    @config   = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(@config)
    @planet   = @universe.create_planet( 'jupiter', [1, 1] )
  end

  def test_initialize
    @universe.expects( :generate_id ).with( "F" ).returns( "F000" )
    fleet = S2C::Models::Fleet.new( @planet )

    assert_equal( "F000",             fleet.id )
    assert_equal( @universe,          fleet.universe )
    assert_equal( @planet,            fleet.planet )
    assert_equal( 0,                  fleet.level )
    assert_equal( 'fleet',            fleet.type )
    assert_equal( :standby,           fleet.status )
  end

  def test_add_ships
    fleet = S2C::Models::Fleet.new( @planet )

    ship1 = @planet.build_ship

    fleet.add_ships( [ship1] )

    assert_equal( [ship1], fleet.ships )
  end

  def test_travel
    fleet = S2C::Models::Fleet.new( @planet )

    traveling_to = @universe.create_planet( 'jupiter', [10, 10] )

    fleet.travel( traveling_to )

    assert_equal( traveling_to, fleet.traveling_to )
    assert_equal( :traveling, fleet.status )
  end

  def from_opts
    opts = {
      "status" => "status"
    }

    fleet = S2C::Models::Fleet.new( @planet, opts )

    assert_equal( "status", fleet.status )
  end

end